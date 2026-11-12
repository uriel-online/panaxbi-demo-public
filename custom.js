xo.spaces["expanded"] = "http://panax.io/state/expanded";
xo.spaces["visible"] = "http://panax.io/state/visible";
xo.spaces["hidden"] = "http://panax.io/state/hidden";
function navegarTracto(tracto_id) {
    location.href = new URL(`${location.pathname}?@tr=${tracto_id}${location.hash}`, location.origin)
}

function mostrarTracto(tractos) {
    for (let option of [...event.srcElement.querySelectorAll(`option:not(.hidden)`)]) {
        let scope = option.hasAttribute("xo-attribute") && option.scope;
        scope && scope.set(option.selected || null);
    }
    //let store = event.target.store;
    //for (tracto of tractos) {
    //    let tracto_id = tracto.value;
    //    let unidades = store.$$(`(//mantenibles/sucursal/tracto|//mantenibles/sucursal/tracto/mantenible)[@num="${tracto_id}"]`);
    //    unidades.set("state:active", tracto.selected || null);
    //}
}

function mostrarPropiedades(filtro) {
    [xo.stores["#inventario"].stylesheets["dashboard_inventario.xslt"]].removeAll();
    xo.site.hash = '#inventario';
    xo.stores["#inventario"].documentElement.set("state:status", filtro);
    xo.stores["#inventario"].render();
}

async function progressiveRequest(params) {
    if (params instanceof Array) {
        params = Object.fromEntries(params);
    }
    let store = xo.stores.seed;
    if (store.selectFirst(`/model/fechas`)) {
        params["@get_dims"] = 0;
    }
    let response = {};
    let source = this;
    let loading, progress;
    if (Object.keys(params).filter(key => key.match(/@get_n\d/)).length) {
        this.settings.progress = await xo.sources["loading.xslt"].render();
        progress = this.settings.progress[0].querySelector('i progress');
        progress.style.display = 'inline';
    }
    let requested_levels = Object.entries(params).filter(([key, value]) => key.match(/@get_n\d/) && value == 1).map(([key]) => key.replace(/@get_n(\d+)/, '$1')).order();
    //Object.keys(params).filter(key => key.match(/@get_n\d/)).forEach((key, ix) => {
    //    if (ix == 0) {
    let new_params = params;//Object.fromEntries(Object.entries(params).filter(([key]) => !key.match(/@get_n\d/)));
    //new_params[key] = params[key];
    progress.appendAfter(xo.xml.createNode(`<label xmlns="http://www.w3.org/1999/xhtml" style="white-space: nowrap; font-size: xx-small; transform: translateY(-40px); color: white; font-weight: bolder;">Cargando nivel ${requested_levels.join(', ')}...</label>`));
    response = xo.server.request.call(this, new_params, { source: source, progress: progress }).then(document => {
        //delete params[key];
        let items = document.select(`/model/polizas|/model/presupuesto`).filter(item => item.firstElementChild);
        document.seed();

        let current_date_er = new Date().toISOString().replace('-', '').substring(0, 6);
        let fechas = document.selectFirst(`model/fechas`);
        if (fechas) {
            fechas.set("state:current_date_er", current_date_er);
        }

        let target_model = store.selectFirst(`/model`);
        if (target_model) {
            store.observer.disconnect();
            for (item of items) {
                let dims = item.select(`@div|@rs|@un`);
                let levels = [...new Set(item.select(`*/@n1|*/@n2|*/@n3|*/@n4|*/@n5|*/@n6`).map(n => n.value))];
                let matches = target_model.select(`${item.nodeName}${dims.map(el => `[@${el.name}="${el.value}"]`).join('')}`);
                if (!matches.length) {
                    target_model.append(item)
                } else {
                    for (let target of matches) {
                        target.select(`*/@n1|*/@n2|*/@n3|*/@n4|*/@n5|*/@n6`).filter(attr => levels.includes(attr.value)).forEach(attr => attr.remove({ silent: true }));
                        target.select(`*[not(@n1 or @n2 or @n3 or @n4 or @n5 or @n6)]`).forEach(el => el.remove({ silent: true }));
                        target.append(...item.select('*'));
                    }
                }
                //xo.stores.seed.select(`/model/polizas/*/@n${key.substring(6)}`).forEach(el => original_remove.apply(el.parentNode));
                //xo.stores.seed.select(`/model/presupuesto/*/@n${key.substring(6)}`).forEach(el => original_remove.apply(el.parentNode));
                //xo.stores.seed.select('//model').forEach(polizas => polizas.append(...document.select('//model/polizas'), { silent: true }));
                //xo.stores.seed.select('/model').forEach(polizas => polizas.append(...document.select('/model/presupuesto'), { silent: true }));
            }
            xo.stores.seed.observer.connect();
        }

        //progressiveRequest.call(this, params);
        xo.stores.seed.render();
        if (xo.stores.seed.documentElement) {
            return Promise.resolve(xo.stores.seed.document);
        } else {
            return Promise.resolve(document);
        }
    }).catch(e => {
        return Promise.reject(e);
    }).finally(() => {
        loading && loading.forEach(el => el.remove());
    });
    //    }
    //});
    return response;
}

xo.listener.on('change::fecha/@mth', async function ({ element }) {
    let document = this.ownerDocument;
    let definition = document.source.definition;
    let yr = element.getAttribute("yr");
    let mth = element.getAttribute("mth");
    definition["server:request"]["@month"] = `${yr}${mth}`
    try {
        let target = document.selectFirst('//indicadores');
        let response = await document.source.fetch();
        for (let fecha of response.select(`//indicador`).map(indicador => `${indicador.getAttribute("yr")}-${indicador.getAttribute("month")}`).distinct()) {
            let [yr, mth] = fecha.split('-');
            target.select(`indicador[@yr="${yr}"][@month="${mth}"]`).remove();
        }
        target.append(...response.select('//indicadores/indicador'));
    } catch (e) {
        Promise.reject(e);
    }
})

xo.listener.on('xo.Source:fetch', async function ({ settings = {} }) {
    let progress = await settings.progress;
    progress && progress.remove();
})

Object.defineProperty(xo.session, 'login', {
    value: async function (username, password, connection_id) {
        try {
            xover.session.user_login = username
            xover.session.status = 'authorizing';
            let response = await xover.server.login(new URLSearchParams({ 'connection_id': connection_id }), { headers: { authorization: `Basic ${btoa(username + ':' + password)}` } });
            xover.session.status = 'authorized';
            xover.stores.active.render();
        } catch (e) {
            xover.session.status = 'unauthorized';
            Promise.reject(e);
        }
    }, writable: true, configurable: true
})

Object.defineProperty(xo.session, 'logout', {
    value: async function () {
        try {
            let response = await xover.server.logout();
            for (store in xo.stores) {
                xo.stores[store].remove()
            }
            xover.session.status = 'unauthorized';
            history.go(-xo.site.position + 1);
        } catch (e) {
            Promise.reject(e);
        }
    }, writable: true, configurable: true
})

xo.listener.on('fetch::model[not(//processing-instruction())]', function ({ document, store }) {
    let tag = store.tag;
    document.addStylesheet({ href: tag.substring(1).split(/\?/, 1).shift() + '.xslt', target: "@#shell main" });
})

xo.listener.on(['beforeFetch::#polizas', 'beforeFetch::#capital_trabajo', 'beforeFetch::#flujo_efectivo', 'beforeFetch::#razones_financieras', 'beforeFetch::#concentrado_er_balance', 'beforeFetch::#productividad_individual'], function () {
    this.settings.progress = xo.sources["loading.xslt"].render();
})

xo.listener.on('hashchange', function () {
    if (typeof toggleSidebar === "function") toggleSidebar(false)
})

//xo.listener.on('progress', function ({ percent, document, source }) {
//    if (percent == 100) {
//        console.log('Download complete.');
//    } else {
//        console.log(`Download progress: ${percent}%`);

//    }
//})

xo.listener.on('progress', async function ({ percent }) {
    let progress = await this.settings.progress;
    if (progress) {
        progress = [progress].flat(Infinity);
        let target = progress[0].parentNode ?.querySelector('progress');
        if (target) {
            target.style.display = 'inline'
            target.value = percent;
        }
    }
})

xo.listener.on('beforeRender', ({ dom }) => {
    dom.querySelectorAll(".cell[fecha]").forEach(cell => { cell.setAttributes(cell.select("ancestor-or-self::*/@div[1]|ancestor-or-self::*/@rs[1]|ancestor-or-self::*/@un[1]|ancestor-or-self::*/@cta[1]|ancestor-or-self::*/@cl[1]|ancestor-or-self::*/@fecha[1]").reduce((obj, attr) => { obj[attr.name] = attr.value || ''; return obj }, {})) });
})

xo.listener.on(['beforeRender::#flujo_efectivo.xslt'], ({ dom }) => {
    dom.querySelectorAll(".cell").forEach(cell => { cell.setAttributes(cell.select("ancestor-or-self::*/@div[1]|ancestor-or-self::*/@rs[1]|ancestor-or-self::*/@un[1]|ancestor-or-self::*/@cta[1]|ancestor-or-self::*/@cl[1]|ancestor-or-self::*/@fecha[1]").reduce((obj, attr) => { obj[attr.name] = attr.value || ''; return obj }, {})) });
})

xo.listener.on(['render::#estado_resultados_mensual.xslt', 'render::#razones_financieras.xslt', 'render::#capital_trabajo.xslt', 'change::state:validate', 'render::#flujo_efectivo.xslt'], ({ dom }) => {
    if (xo.state.validate) {
        validation.highlight()
    } else {
        [...document.querySelectorAll('.valid,.invalid')].forEach(el => el.classList.remove('valid', 'invalid'))
    }
})

xo.listener.on(['render::#concentrado_er_balance.xslt', 'render::#concentrado_er.xslt'], async ({ }) => {
    top.document.querySelectorAll('table tr td:nth-child(1)').forEach(el => !el.closest('thead') && el.classList.add('freeze'))
})

xo.listener.on(['beforeRender::#shell.xslt', 'beforeAppendTo::main', 'beforeAppendTo::body'], function ({ target, event }) {
    if (!(event.detail.args || []).filter(el => !(el instanceof Comment || el instanceof HTMLStyleElement || el instanceof HTMLScriptElement || el.matches("dialog,[role=alertdialog],[role=alert],[role=dialog],[role=status],[role=progressbar]"))).length) return;
    [...target.childNodes].filter(el => el.matches && !el.matches(`script,dialog,[role=alertdialog],[role=alert],[role=dialog],[role=status],[role=progressbar]`)).removeAll()
})

xo.listener.on('beforeRender', ({ target, stylesheet }) => {
    if (/*[""].includes((stylesheet || {}).href) && */target.querySelector('.offcanvas.show')) {
        //event.preventDefault()
    }
})

xo.listener.on(['set::@state:selectedLevel', 'set::@state:expanded'], function ({ store, value, old = 0, event }) {
    let expandir = !!eval(value)
    let srcElement = (event.srcEvent || {}).srcElement || event.srcElement;
    xo.site.state.expanded = xo.site.state.expanded || new Map();
    xo.site.state.hidden = xo.site.state.hidden || new Map();
    let expanded = xo.site.state.expanded;
    let hidden = xo.site.state.hidden;
    nivel = Number(value) == value && Number(value) || Number(`${this.parentNode.selectFirst("self::cuenta/@n") || ''}`) + 1
    let attrs = Object.fromEntries(srcElement.select('ancestor::*/@cta[1]|ancestor::*/@div[1]|ancestor::*/@rs[1]|ancestor::*/@un[1]').filter(el => el.value).map(el => [el.name, el.value]));
    !expandir && [...srcElement.closest('tbody').querySelectorAll(`.cta_${attrs.cta}`)].remove();
    if (isFinite(value)) {
        let remove_accts = this.ownerDocument.select(`/model/cuentas//cuenta/descendant-or-self::cuenta[@n>="${isFinite(value) ? value : '@n'}"]/@id`).map(String);
        for (let [key] of [...expanded, ...hidden]) {
            let cta = JSON.parse(key)["cta"];
            for (let acct of remove_accts) {
                if (cta == acct) {
                    expanded.delete(key)
                    hidden.delete(key)
                }
            }
        }
    }
    if (expandir) {
        expanded.set(JSON.stringify(attrs), value);
        hidden.delete(JSON.stringify(attrs));
    } else {
        expanded.delete(JSON.stringify(attrs));
        hidden.set(JSON.stringify(attrs), value);
    }
    if (!expandir) return;
    let definition = store.source.definition || {};
    if (!definition["progressiveRequest"]) return;
    let node = this;

    let fetch = false;
    let dims = srcElement.select('ancestor::*[@div][1]/@div|ancestor::*[@rs][1]/@rs|ancestor::*[@un][1]/@un').filter(el => el.value);
    definition['progressiveRequest']["@cta"] = `${this.parentNode.selectFirst("self::cuenta/@id") || ''}` || null;

    let selected_years = this.ownerDocument.select(`model/fechas/fecha[@state:checked]/@mes|model/fechas[not(fecha/@state:checked)]/@state:current_date_er`).map(el => el.value.substring(0, 4)).distinct();
    delete definition['progressiveRequest']["@fecha"];
    if (selected_years.length == 1) {
        definition['progressiveRequest']["@fecha"] = selected_years.pop();
    }
    expanded = [...xo.site.state.expanded.keys()].map(el => JSON.parse(el)).filter(json => dims.every(attr => json[attr.nodeName] == attr.value));
    //let maxLevel = Math.max(...expanded.map(json => accounts.find(account => account.value == json.cta).parentNode.getAttribute("n")).distinct()) + 1;
    let maxLevel = isFinite(value) && Number(value) || Math.max(...this.ownerDocument.select(`/model/cuentas//cuenta[@id="${definition['progressiveRequest']["@cta"]}"]/descendant-or-self::cuenta/@id`).filter(attr => expanded.find(json => json.cta == attr.value)).map(attr => +attr.parentNode.getAttribute("n")).distinct()) + 1;
    if (expandir) {
        for (let i = 1; i <= 5; ++i) {
            let scoped_accounts = this.ownerDocument.select(`/model/cuentas//cuenta[@id=${definition['progressiveRequest']["@cta"] || '@id'}]/descendant-or-self::cuenta[@n="${i}"]/@id`);
            if (i > maxLevel || !scoped_accounts.length || store.selectFirst(`/model/*${dims.filter(attr => !(i == 1 && attr.value == '0')).map(el => `[@${el.name}="${el.value}"]`).join('')}/*[${scoped_accounts.map(el => `@n${el.parentNode.getAttribute("n")}="${el.value}"`).join(' or ')}]/@fecha[starts-with(.,'${definition['progressiveRequest']["@fecha"]}')]`)) {
                delete definition["progressiveRequest"][`@get_n${i}`];
            } else {
                fetch = true
                definition["progressiveRequest"][`@get_n${i}`] = 1;
            }
        };
    }
    if (fetch) {
        dims.forEach(el => definition["progressiveRequest"][`@${el.name}`] = el.value);
        store.document.source.settings["expiry"] = 1;
        store.document.source.fetch()
    }
    if (this.parentNode.matches("cuentas")) {
        xo.stores.seed.select(`//cuentas//cuenta/@state:expanded`).remove({ silent: true });
        for (let i = 1; i <= nivel - 1; ++i) {
            xo.stores.seed.select(`//cuentas//cuenta[@n="${i}"]`).forEach(cta => cta.set("state:expanded", "true", { silent: true }));
            xo.stores.seed.render();
        }
    }
})

xo.listener.on('beforeSet::fecha/@state:checked', function ({ value, event }) {
    this.parentNode.select("//model/fechas/@state:current_date_er").remove()
    if (!(event.srcEvent.target instanceof SVGElement)) {
        this.parentNode.select("parent::fechas/fecha/@state:checked").filter(attr => attr != this).removeAll();
    }
    if (value == 'true') {
        let current_year = this.parentNode.getAttribute('mes').substring(0, 4);
        let expanded_array = xo.site.state.expanded;
        for (let [obj, expanded] of [...expanded_array || []]) {
            let config = JSON.parse(obj);
            let account_list = this.ownerDocument.select(`/model//cuenta[@id=${config.cta || "@id"}]/*/ancestor-or-self::cuenta[@n<=${isFinite(expanded) ? expanded : "@n"}]/@id`).map(n => n.value);
            let matches = this.selectFirst(`/model/*${Object.entries(config).filter(([key]) => key != 'cta').map(([key, value]) => `[@${key}="${value}"]`).join('')}/@fecha[starts-with(.,'${current_year}')]`);
            if (!matches) expanded_array.delete(obj);
        }
    }
}, true)

xo.listener.on('beforeSet::@state:*', function ({ event }) {
    let srcElement = (event.srcEvent || {}).target;
    if (srcElement instanceof SVGElement || srcElement instanceof HTMLElement) {
        srcElement.classList.add("xo-working");
    }
}, true)

xo.listener.on('change::unidad_negocio/@state:checked', function () {
    this.ownerDocument.select(`//mantenibles//@state:active`).forEach(el => el.remove())
}, true)

xo.listener.on('change::razon_social/@state:checked[.="true"]', function ({ target, stylesheet }) {
    this.parentNode.select("@div").map(div => div.parentNode.select(`//model/divisiones/division[@id="${div.value}"][not(@state:checked)]`).set("state:checked", this.value))
})

xo.listener.on('remove::divisiones/division/@state:checked', function ({ target, stylesheet }) {
    for (let div of this.parentNode.select("@id")) {
        div.parentNode.select(`//model/razones_sociales/razon_social[@div="${div.value}"]/@state:checked|//model/unidades_negocio/unidad_negocio/@state:checked`).remove()
    }
})

function DynamicObject(obj) {
    if (!(this instanceof DynamicObject)) return new DynamicObject(obj);
    let proxy_manager = function (target, name) {
        let return_value
        if (["getValue", "hasOwnProperty", "realValue"].includes(name) || typeof target[name] === 'function') {
            return target[name];
        }
        if (name in target && target[name] !== undefined && target[name] !== null) {
            if (typeof (target[name]) == 'string') {
                return_value = new String(target[name]);
            } else if (typeof (target[name]) == 'number') {
                return_value = new Number(target[name]);
            } else if (typeof (target[name]) == 'boolean') {
                return_value = new Boolean(target[name]);
            } else if (target[name].constructor === {}.constructor) {
                return_value = new Proxy(target[name], { get: proxy_manager });
            } else {
                return_value = target[name];
            }
        } else {
            return_value = new Proxy({}, { get: proxy_manager });
            Object.setPrototypeOf(return_value, Array.prototype)
            Object.defineProperty(return_value, 'realValue', {
                value: undefined,
                writable: true, enumerable: false, configurable: false
            });
        }
        if (!(return_value.hasOwnProperty('getValue'))) {
            Object.defineProperty(return_value, 'getValue', {
                value: function () {
                    if (this.hasOwnProperty('realValue')) {
                        return this.realValue;
                    } else {
                        return target[name];
                    }
                },
                writable: false, enumerable: false, configurable: false
            });
        }
        return return_value;
    }
    let new_obj = new Proxy(obj, { get: proxy_manager });
    Object.setPrototypeOf(new_obj, this);
    return new_obj;
}

xo.listener.on('beforeTransform::model[not(@env:stylesheet="title.xslt" or @env:stylesheet="page_controls.seleccion.xslt" or @env:stylesheet="page_controls.validacion.xslt")]', function ({ target, store, stylesheet }) {
    this.disconnect();
    if (["razones_financieras.xslt"].includes(stylesheet.href)) {
        for (let month of this.select('//fechas/fecha/@mth')) {
            let yr = month.parentNode.getAttribute("yr")
            this.select(`//indicadores/indicador[@yr="${yr}"][not(@month="${month}")]`).remove();
        }
    }
    if (!["page_controls", "page_navbar"].includes(stylesheet.href.split('.')[0])) {
        env = this
    }
    let selected_date = `${this.selectFirst("model/fechas/@state:current_date_er") || this.selectFirst("model/fechas/@state:current_year") || this.selectFirst("model/fechas/fecha[@state:checked][last()]/@mes") || Math.max(... new Set(this.select("model/polizas/poliza/@fecha").filter(el => isFinite(el.value)).map(el => el.value)), new Date().toISOString().replace('-', '').substring(0, 6))}`;
    if (isFinite(selected_date)) {
        this.select(`model/fechas[not(fecha/@state:checked)]/fecha[@mes="${selected_date.substring(0, 4)}01"]`).forEach(fecha => fecha.setAttribute('state:checked', true));
        this.select(`model/fechas`).forEach(node => node.setAttribute("state:current_date_er", selected_date))
    }

    this.select(`/model/*/*/@monto`).filter(monto => !(+monto && isFinite(monto.value))).forEach(el => original_remove.apply(el.parentNode))

    let active_accounts = [];
    //if (this.selectFirst("/model[contains(@env:store, '_alt')]") || store.tag == '#estado_resultados_mensual' || store.tag == '#estado_resultados') {
    //    active_accounts = this.select(`model/cuentas//*[@n=1 or parent::*[@state:expanded="true"] and not(ancestor::*[@state:expanded="false"])]/@id`).map(cta => cta.value);
    //    this.select('/model/*/*/@n2|/model/*/*/@n3|/model/*/*/@n4|/model/*/*/@n5').filter(el => !active_accounts.includes(el.value)).forEach(attr => attr.remove({ silent: true }));
    //    this.select(`/model/polizas/*[not(@n1 or @n2 or @n3 or @n4 or @n5 or @n6)]|/model/presupuesto/*[not(@n1 or @n2 or @n3 or @n4 or @n5 or @n6)]`).forEach(el => el.remove({ silent: true }));
    //}

    if (['estado_resultados_unidad.xslt', 'estado_resultados_tracto.xslt'].includes(stylesheet.href)) {
        let mantenibles = env.select(`//mantenibles//*[.//@state:active]/@num`).map(num => num.value);
        mantenibles.length && this.select(`//model/*/*/@tr|//model/*/*/@m`).filter(el => !mantenibles.includes(el.value)).forEach(el => original_remove.apply(el.parentNode));
    }
    if (stylesheet.href == 'estado_resultados_tracto.xslt' || xo.site.active == '#estado_resultados_tracto' && stylesheet.href == 'page_controls.xslt') {
        this.select(`//model/polizas/poliza[@fecha!="${selected_date}"]`).forEach(el => original_remove.apply(el));
    }

    if (!["page_controls.xslt", "page_navbar.xslt", "page_controls.mantenibles.xslt", "shell_buttons.xslt"].includes(stylesheet.href)) {
        let unidades_seleccionadas = [...new Set(this.select("//unidades_negocio/unidad_negocio[@state:checked]/@id").map(el => el.value))];
        unidades_seleccionadas.length && this.select(`//model/*/*/@un|//model/*/@un`).filter(el => !unidades_seleccionadas.includes(el.value)).forEach(el => original_remove.apply(el.parentNode));
    }

    //if (stylesheet.href == 'razones_financieras.xslt') {
    //    let divisiones = this.select("//razones_sociales/razon_social[@state:checked]/@div|//divisiones/division[@state:checked]/@id");
    //    divisiones.length && this.select(`//indicadores/indicador[not(${divisiones.map(attr => `@div="${attr.value}"`).join(" or ")})]`).forEach(el => original_remove.apply(el));
    //    let razones_sociales = this.select("//razones_sociales/razon_social[@state:checked]/@id");
    //    razones_sociales.length && this.select(`//indicadores/indicador[not(${razones_sociales.map(attr => `@rs="${attr.value}"`).join(" or ")})]`).forEach(el => original_remove.apply(el));
    //    //let unidades_seleccionadas = this.select("//unidades_negocio/unidad_negocio[@state:checked]");
    //    //unidades_seleccionadas.length && this.select(`//model/polizas/poliza[not(${unidades_seleccionadas.map(el => `@un="${el.getAttribute("id")}"`).join(" or ")})]`).forEach(el => original_remove.apply(el));
    //}
    if (stylesheet.href == 'estado_resultados.xslt') {
        this.select(`/model/*/*[@fecha][not(starts-with(@fecha,"${`${this.selectFirst("//@state:current_date_er") || new Date().getFullYear()}`.substr(0, 4)}") or starts-with(@fecha,"${`${this.selectFirst("//@state:current_date_er") || new Date().getFullYear()}`.substr(0, 4) - 1}"))]`).forEach(el => original_remove.apply(el));
    }
    ////if (stylesheet.href == 'estado_resultados_mensual.xslt') {
    ////    let selected_years = [new Date().getFullYear()];
    ////    this.select(`//model/polizas/poliza[not(starts-with(@fecha,"${`${this.selectFirst("//@state:current_date_er") || new Date().getFullYear()}`.substr(0, 4)}") or starts-with(@fecha,"${`${this.selectFirst("//@state:current_date_er") || new Date().getFullYear()}`.substr(0, 4) - 1}"))]`).forEach(el => original_remove.apply(el));
    ////}
    //if (stylesheet.href == 'estado_resultados_unidad.xslt' || stylesheet.href == 'estado_resultados.xslt' || stylesheet.href == 'estado_resultados_mensual.xslt' || stylesheet.href == 'page_controls.xslt' || stylesheet.href == 'page_navbar.xslt') {
    let divisiones = this.select("//razones_sociales/razon_social[@state:checked]/@div|//divisiones/division[@state:checked]/@id").map(el => el.value).distinct();
    //divisiones.length && this.select(`//model/polizas/poliza[not(${divisiones.map(attr => `@div="${attr.value}"`).join(" or ")})]`).forEach(el => original_remove.apply(el));
    divisiones.length && this.select(`//model/*[not(self::razones_sociales)]/*/@div|//model/*/@div`).filter(el => !divisiones.includes(el.value)).forEach(el => original_remove.apply(el.parentNode));

    let razones_sociales = this.select("//razones_sociales/razon_social[@state:checked]/@id").map(el => el.value).distinct();
    //razones_sociales.length && this.select(`//model/polizas/poliza[not(${razones_sociales.map(attr => `@rs="${attr.value}"`).join(" or ")})]`).forEach(el => original_remove.apply(el));
    razones_sociales.length && this.select(`//model/*/@rs|//model/*/*/@rs`).filter(el => !razones_sociales.includes(el.value)).forEach(el => original_remove.apply(el.parentNode));

    if (!razones_sociales.length && ["razones_financieras.xslt"].includes(stylesheet.href)) {
        this.select(`//indicadores/indicador`).remove();
    }

    let active_un = this.select('//model/*/@un|//model/*/*/@un|//carteras/cartera/@un').map(el => el.value).filter(el => el != '0').distinct();
    if (active_un.length && !(stylesheet.href == 'page_controls.xslt' && !['#estado_resultados'].includes(store.tag))) {
        let missing_un = active_un.filter(un => !this.select('//unidades_negocio/unidad_negocio/@id').map(el => el.value).includes(un));
        missing_un.filter(un => store.selectFirst(`//unidades_negocio[not(*[@id="${un}"])]`)).forEach(un => store.selectFirst(`//unidades_negocio`).append(xo.xml.createNode(`<unidad_negocio id="${un}" cve="" nom="${un == -1 && "N/D" || ""}" xmlns:xo="http://panax.io/xover"/>`)));
    }
    this.select("//unidades_negocio/unidad_negocio/@id").filter(el => !active_un.includes(el.value)).forEach(el => original_remove.apply(el.parentNode));
    if (stylesheet.href == 'page_controls.xslt') {
        this.select(`/model[not(divisiones/division[@state:checked="true"])]/unidades_negocio/unidad_negocio/@id`).forEach(el => original_remove.apply(el.parentNode));
    }

    let active_years = [selected_date.substring(0, 4)].concat(this.select('//fechas/fecha[@state:checked="true"]/@mes').map(el => el.value.substring(0, 4))).distinct();

    if (["estado_resultados.xslt"].includes(stylesheet.href)) {
        let er_valid_dates = [selected_date].map(fecha => [`${fecha.substr(0, 4)}${fecha.substr(4, 2)}`, `${fecha.substr(0, 4) - 1}${fecha.substr(4, 2)}`, `${fecha.substr(0, 4)}~${fecha.substr(4, 2)}`, `${fecha.substr(0, 4) - 1}~${fecha.substr(4, 2)}`, `${fecha.substr(0, 4) - 1}~12`, `${fecha.substr(0, 4)}~12`]).pop();
        let er_valid_budget_dates = er_valid_dates.concat(this.select(`/model/fechas/fecha[@mes='${selected_date}']/following-sibling::fecha`).slice(0, 3).map(fecha => fecha.getAttribute("mes")));
        this.select(`/model/polizas/poliza/@fecha`).filter(fecha => !er_valid_dates.includes(fecha.value)).forEach(el => original_remove.apply(el.parentNode));
        this.select(`/model/presupuesto/presupuesto/@fecha`).filter(fecha => !er_valid_budget_dates.includes(fecha.value)).forEach(el => original_remove.apply(el.parentNode));
    } else if (["concentrado_er_balance.xslt"].includes(stylesheet.href)) {
        active_years.length && this.select(`/model/*/*/@fecha[not(contains(.,'~'))]`).filter(el => !active_years.includes(el.value.substring(0, 4))).forEach(el => original_remove.apply(el.parentNode))
    } else if (!["page_controls", "page_navbar", "inventario_mermas"].includes(stylesheet.href.split('.')[0])) {
        active_years.length && this.select(`/model/*/*/@fecha[not(contains(.,'~12') or starts-with(.,'~')${['capital_trabajo.xslt'].includes(stylesheet.href) ? ` or .='${selected_date.substring(0, 4) - 1}12'` : ''})]`).filter(el => !active_years.includes(el.value.substring(0, 4))).forEach(el => original_remove.apply(el.parentNode))
    }

    let active_fecha = this.select('/model/*/*/@fecha').map(String).distinct();
    if (!active_years.length) {
        active_years = active_fecha.map(value => value.substring(0, 4)).distinct();
    }
    if (["estado_resultados_unidad.xslt"].includes(stylesheet.href)) {
        this.select("/model[@env:store='#estado_resultados_unidad']/fechas/fecha[substring(@mes,5,7)='12']/@mes").forEach(fecha => fecha.parentNode.duplicate().set("mes", fecha.value.substring(0, 4)).set("nom", fecha.value.substring(0, 4)).seed(true).removeAttribute("limit"))
        this.select(`model/fechas[count(fecha/@limit)>1]/fecha[not(@limit or string-length(@mes)=4) and not(preceding-sibling::fecha/@limit and following-sibling::fecha/@limit)]`).forEach(el => original_remove.apply(el));
        active_years.length && this.select(`model/fechas/fecha/@mes`).filter(mes => !active_years.includes(mes.value.substring(0,4))).forEach(el => original_remove.apply(el.parentNode));

        active_fecha = this.select('/model/fechas/fecha/@mes').map(String);
        active_fecha.length && this.select(`/model/*/*/@fecha`).filter(el => !active_fecha.includes(el.value)).forEach(el => original_remove.apply(el.parentNode))
    }

    this.select("/model[@env:store='#estado_resultados' or @env:store='#estado_resultados_tracto' or not(@env:stylesheet='page_navbar.xslt')]/fechas/fecha/@mes").filter(el => !(active_fecha.includes(el.value) || /*["#flujo_efectivo", "#capital_trabajo"].includes(store.tag) && */active_years.includes(el.value.substring(0, 4)))).forEach(el => original_remove.apply(el.parentNode));
    //}
    if (stylesheet.href != 'page_controls.xslt') {
        divisiones.length && this.select("//razones_sociales/razon_social/@div|//divisiones/division/@id").filter(el => !divisiones.includes(el.value)).forEach(el => original_remove.apply(el.parentNode));
        razones_sociales.length && this.select("//razones_sociales/razon_social/@rs").filter(el => !razones_sociales.includes(el.value)).forEach(el => original_remove.apply(el.parentNode));

        let productos_activos = this.select("//@prod").map(attr => attr.value).distinct();
        this.select("//productos/producto/@id").filter(el => !productos_activos.includes(el.value)).forEach(el => original_remove.apply(el.parentNode));
    }
    if (stylesheet.href == 'page_navbar.xslt') {
        this.select('/model/polizas|/model/presupuesto|/model/compras|/model/ventas').forEach(el => original_remove.apply(el));
    }
    if (["estado_resultados_mensual.xslt", "estado_resultados.xslt"].includes(stylesheet.href)) {
        for (let [obj, expanded] of [...xo.site.state.expanded || []]) {
            let config = JSON.parse(obj);
            let account_list = this.select(`/model//cuenta[@id=${config.cta || "@id"}]/*/ancestor-or-self::cuenta[@n<=${isFinite(expanded) ? expanded : "@n"}]/@id`).map(n => n.value);
            let matches = this.select(`/model/*${Object.entries(config).filter(([key]) => key != 'cta').map(([key, value]) => `[@${key}="${value}"]`).join('')}`);
            for (let n of matches) {
                for (let cta of account_list) {
                    n.setAttribute(`visible:dims_${config.div || ''}_${config.rs || ''}_${config.un || ''}_${cta}`, cta, { silent: true });
                }
            }
        }
        for (let [obj, hidden] of [...xo.site.state.hidden || []]) {
            let config = JSON.parse(obj);
            let account_list = this.select(`/model//cuenta[@id="${config.cta}"]/*/descendant-or-self::cuenta/@id`).map(n => n.value);
            let matches = this.select(`/model/*${Object.entries(config).filter(([key]) => key != 'cta').map(([key, value]) => `[@${key}="${value}"]`).join('')}`);
            for (let n of matches) {
                for (let cta of account_list) {
                    n.removeAttribute(`visible:dims_${config.div || ''}_${config.rs || ''}_${config.un || ''}_${cta}`, { silent: true })
                }
            }
        }
        for (let node of this.select(`/model/polizas|/model/presupuesto`)) {
            let expanded = node.select(`@visible:*`).map(attr => attr.value);
            node.select('*/@n2|*/@n3|*/@n4|*/@n5').filter(el => !expanded.includes(el.value)).forEach(attr => attr.remove({ silent: true }));
        }
        this.select(`/model/polizas/*[not(@n1 or @n2 or @n3 or @n4 or @n5 or @n6)]|/model/presupuesto/*[not(@n1 or @n2 or @n3 or @n4 or @n5 or @n6)]`).forEach(el => el.remove({ silent: true }));
    }

    //if (['estado_resultados_tracto.xslt'].includes(stylesheet.href)) {
    let mantenibles = this.select(`//model/*/*/@tr|//model/*/*/@m`).map(tr => tr.value);
    this.select(`//mantenibles//*[@num]`).filter(el => !mantenibles.length || !el.select('descendant-or-self::*/@num').some(tr => mantenibles.includes(tr.value))).forEach(el => original_remove.apply(el));
    //}
    let active_tr = [...new Set(this.select('//model[mantenibles]/*/*/@tr').map(el => el.value))];
    if (active_tr.length) {
        let mantenibles = this.select(`//mantenibles//*/@num`).map(el => el.value);
        let missing_tr = active_tr.filter(tr => !mantenibles.includes(tr));
        if (missing_tr.length) {
            missing_tr.forEach(tr => store.selectFirst(`//mantenibles`).append(xo.xml.createNode(`<tracto num="${tr}" nom="${tr == -1 && "N/D" || ""}" xmlns:xo="http://panax.io/xover"/>`)));
        }
    }
    //if (1 == 0 && ['#estado_resultados'].includes(store.tag) && !(stylesheet.href == 'page_controls.xslt' || stylesheet.href == 'page_navbar.xslt' || stylesheet.href == 'shell_buttons.xslt' || stylesheet.href == 'title.xslt')) {
    //    let aggregated = this.select(`/model/*/*[@fecha]`).reduce((distinct, node) => {
    //        let obj = Object.fromEntries(node.select("@*").map(node => [node.name, node.value]));
    //        let type = [node.localName];
    //        //let div = "div_" + obj.div;
    //        distinct[type] = distinct[type] || {};
    //        distinct[type] = distinct[type] || {};
    //        distinct[type][obj.fecha] = distinct[type][obj.fecha] || {};
    //        for (let i = 1; i <= 5; i++) {
    //            if (obj["n" + i]) {
    //                distinct[type][obj.fecha]["cta_" + obj[`n${i}`]] = distinct[type][obj.fecha]["cta_" + obj[`n${i}`]] || {};
    //                distinct[type][obj.fecha]["cta_" + obj[`n${i}`]]["monto"] = (distinct[type][obj.fecha]["cta_" + obj[`n${i}`]]["monto"] || 0) - (- (obj.monto || 0));
    //            }
    //        }
    //        return distinct
    //    }, {});
    //    let aggregated_alt = this.select(`/model/*/*[@fecha]`).reduce((distinct, node) => {
    //        let fecha = node.getAttribute("fecha");
    //        let obj = Object.fromEntries([[node.localName, Object.fromEntries([[fecha.substring(0, 4), Object.fromEntries([[fecha, Object.fromEntries(node.select("@div|@rs|@un|../@div|../@rs|../@un|@*[substring(local-name(),1,1)='n']|@cl").map(node => [...[["n1", "n2", "n3", "n4", "n5", "n6"].includes(node.name) && "cta" || node.name, node.value]]))]])]])]]);
    //        //let div = "div_" + obj.div;
    //        let key = JSON.stringify(obj);
    //        let monto = parseFloat(node.getAttribute("monto"));
    //        let value = distinct.get(key) || 0;
    //        distinct.set(key, value + monto);
    //        return distinct
    //    }, new Map());
    //    let entries = []
    //    aggregated_alt = [...aggregated_alt].map(([key, value]) => [JSON.parse(key), value]);
    //    let xml = `<env:calcs xmlns:env="http://panax.io/state/environment">`
    //    let lines = {};
    //    for (let [json, value] of [...aggregated_alt]) {
    //        for (let type in json) {
    //            //for (let div in json[type]) {
    //            //for (let key in json[type]) {
    //            lines[type] = lines[type] || {};
    //            for (let year in json[type]) {
    //                lines[type][year] = lines[type][year] || {};
    //                for (let fecha in json[type][year]) {
    //                    let record = json[type][year][fecha];
    //                    let dims = JSON.stringify(json[type][year][fecha]);
    //                    let { div, rs, un, cta } = json[type][year][fecha];
    //                    for (let month = parseInt(fecha); month <= parseInt(`${year}12`); ++month) {
    //                        lines[type][year][month] = lines[type][year][month] || {};
    //                        lines[type][year][month][dims] = lines[type][year][month][dims] || {};
    //                        lines[type][year][month][dims].ytd = lines[type][year][month][dims].ytd || 0;
    //                        lines[type][year][month][dims].ytd += value;
    //                        if (month == fecha) {
    //                            lines[type][year][month][dims].monto = value;
    //                        }
    //                    }
    //                }
    //                //}
    //            }
    //            //}
    //            //}
    //        }
    //        //[...aggregated_alt].reduce((ytd, [key, value]) => [JSON.parse(key), value]).filter(([key, value]) => ((key["presupuesto"] || {})["2022"] || {})["fecha"] <= "202212")[0];
    //        //entries.push[JSON.parse(key), value]
    //    }

    //    for (let type in lines) {
    //        for (let year in lines[type]) {
    //            for (let fecha in lines[type][year]) {
    //                for (let [json, values] of Object.entries(lines[type][year][fecha])) {
    //                    xml = xml + `<${type} fecha="${fecha}" ${Object.entries(JSON.parse(json)).map(([key, value]) => `${key}="${value}"`).join(" ")} monto="${values.monto}" ytd="${values.ytd}"/>`
    //                }
    //            }
    //        }
    //    }
    //    //[...aggregated_alt].reduce((ytd, [key, value]) => [JSON.parse(key), value]).filter(([key, value]) => ((key["presupuesto"] || {})["2022"] || {})["fecha"] <= "202212")[0];
    //    //entries.push[JSON.parse(key), value]
    //    //for (let type in aggregated) {
    //    //    //for (let div in aggregated[type]) {
    //    //    for (let key in aggregated[type]) {
    //    //        for (let target in aggregated[type]) {
    //    //            if (key.substring(0, 4) == target.substring(0, 4) && target >= key) {
    //    //                for (let innerKey in aggregated[type][key]) {
    //    //                    aggregated[type][target][innerKey] = aggregated[type][target][innerKey] || {};
    //    //                    aggregated[type][target][innerKey]["ytd"] = aggregated[type][target][innerKey]["ytd"] || 0;
    //    //                    aggregated[type][target][innerKey]["ytd"] = aggregated[type][target][innerKey]["ytd"] - (- aggregated[type][key][innerKey]["monto"] || 0);
    //    //                }
    //    //            }
    //    //            //for (let innerKey in aggregated[type][key]) {
    //    //            //    aggregated[type][target][innerKey] = aggregated[type][target][innerKey] || {};
    //    //            //    aggregated[type][target][innerKey]["saldo"] = aggregated[type][target][innerKey]["saldo"] || 0;
    //    //            //    aggregated[type][target][innerKey]["saldo"] = aggregated[type][target][innerKey]["saldo"] - (- aggregated[type][key][innerKey]["monto"] || 0);
    //    //            //}
    //    //        }
    //    //    }
    //    //    //}
    //    //}
    //    ////let xml = `<env:calcs xmlns:env="http://panax.io/state/environment">`
    //    ////for (let type in aggregated) {
    //    ////    //for (let div in aggregated[type]) {
    //    ////    //for (let key in aggregated[type]) {
    //    ////    for (let fecha in aggregated[type]) {
    //    ////        for (let cta in aggregated[type][fecha]) {
    //    ////            xml = xml + `<${type} fecha="${fecha}" cta="${cta.substring(4)}" monto="${aggregated[type][fecha][cta]["monto"]}" ytd="${aggregated[type][fecha][cta]["ytd"]}"/>`
    //    ////        }
    //    ////    }
    //    ////    //}
    //    ////    //}
    //    ////}
    //    xml = xml + `</env:calcs>`
    //    this.documentElement.append(xover.xml.createNode(xml));
    //    calculations = aggregated;
    //    calcs = this.documentElement.select("env:calcs/*")

    //}
})

xo.listener.on('beforeTransform::#productividad_individual.xslt', function ({ target, store, stylesheet }) {
    this.disconnect()
    store.disconnect();
    store.select(`//ov/line[not(@te)]`).set(line => line.set("te", "", { silent: true }));
    let tractos = this.select('model/tractos/@state:selected|model/tractos/tracto[@state:selected]/id').map(selected => selected.value);
    if (tractos.length) {
        this.select(`model/ov/line/@tr`).filter(tr => !tractos.includes(tr.value)).forEach(el => el.parentNode.remove())
    }
})

xo.listener.on(`change::tiempos/tiempo/@te`, function ({ element, value }) {
    if (!value) {
        if (element.matches("[id]")) {
            element.set("state:delete","true")
        } else {
            element.remove()
        }
    }
})

xo.listener.on(`change::ov/line/@te`, function ({ element, value }) {
    let go = element.get("go");
    let gd = element.get("gd");
    if (!(go && gd)) return Promise.reject('Se requiere geocerca origen y la geocerca destino');
    let un = element.get("un");
    let tiempo = element.select(`/model/tiempos/tiempo[@go="${go}"][@gd="${gd}"]/@te`);
    tiempo.set(value);
    if (!tiempo.length) {
        if (!element.selectFirst(`/model/tiempos`)) element.selectFirst(`/model`).append(xo.xml.createNode(`<tiempos/>`).seed());
        element.selectFirst(`/model/tiempos`).append(xo.xml.createNode(`<tiempo go="${go}" gd="${gd}" te="${value}" un="${un}"/>`).seed());
    }
})

xo.listener.on(['replaceWith::[xo-stylesheet="page_controls.mantenibles.xslt"]'], ({ new_node, old }) => {
    if (!new_node.childNodes.length) {
        new_node.replaceChildren(...old.childNodes)
        //new_node.querySelectorAll("[xo-stylesheet]").toArray().concat([new_node].filter(el => el.matches("[xo-stylesheet]")))
    }
})

xo.listener.on(['transform'], ({ result }) => {
    result.$$('//text()[.="Infinity" or .="-Infinity" or .="NaN" or .="NaN días" or .="0.0" or .="0.0%" or .="(0.0)" or .="0.00" or .="0" or .="(0)" or .="$0"]').remove()
})

//xo.listener.on('beforeRender::#flujo_efectivo_global', ({ document }) => {
//    let new_document = document.cloneNode(true)
//    new_document.documentElement.insertFirst(xo.xml.createNode(`<xo:filters xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xo="http://panax.io/xover">
//	<xo:attributes monto="sum" lts="sum">
//		<div xsi:nil="true" />
//		<rs xsi:nil="true" />
//		<un xsi:nil="true" />
//		<n3 xsi:nil="true" />
//		<cl xsi:nil="true" />
//		<fecha xsi:nil="true" />
//	</xo:attributes>
//</xo:filters>`))
//    new_document = new_document.transform("consolidate_data.xslt")
//    event.detail.document = new_document

//})

//xo.listener.on(['beforeAppendToHTMLElement::BODY'], ({ target, }) => {
//    if (event.detail.args.some(el => el.getAttribute("xo-stylesheet"))) {
//        [...target.childNodes].removeAll()
//    }
//})

function ocultarCuenta(cta) {
    let cta_row = document.querySelector(`#cta_${cta}`);
    if (cta_row) cta_row.classList.add("expandible");
    var style = document.createElement("style");
    style.setAttribute("id", `style_cta_${cta}`);
    style.textContent = `.descendiente_cta_${cta} {display:none}`;
    document.body.append(style)
}

function expandirCuenta(expandir = true) {
    let srcElement = (event.srcEvent || {}).srcElement || event.srcElement;
    xo.site.state.expanded = xo.site.state.expanded || new Map();
    xo.site.state.hidden = xo.site.state.hidden || new Map();
    let expanded = xo.site.state.expanded;
    let hidden = xo.site.state.hidden;
    let attrs = Object.fromEntries(srcElement.select('ancestor::*[@cta][1]/@cta|ancestor::*[@div][1]/@div|ancestor::*[@rs][1]/@rs|ancestor::*[@un][1]/@un').filter(el => el.value).map(el => [el.name, el.value]));
    if (expandir) {
        expanded.set(JSON.stringify(attrs), expandir);
        hidden.delete(JSON.stringify(attrs));
    } else {
        expanded.delete(JSON.stringify(attrs));
        hidden.set(JSON.stringify(attrs), expandir);
    }
    !expandir && [...srcElement.closest('tbody').querySelectorAll(`.cta_${attrs.cta}`)].remove();
    return;
    //let cta_row = document.querySelector(`#cta_${cta}`);
    //if (cta_row) cta_row.classList.remove("expandible");
    //[...document.querySelectorAll(`#style_cta_${cta}`)].removeAll();
}

function ocultar_nivel(nivel) {
    xo.stores.seed.select(`//cuentas//cuenta/@state:expanded`).remove({ silent: true });
    for (let i = 1; i <= nivel - 1; ++i) {
        xo.stores.seed.select(`//cuentas//cuenta[@n="${i}"]`).forEach(cta => cta.set("state:expanded", "true"));
    }
    return;
    [...document.querySelectorAll('#style_nivel')].removeAll()
    if (!nivel) return;
    var style = document.createElement("style");
    style.setAttribute("id", `style_nivel`);
    style.textContent = '';
    for (let i = 10; i > nivel; --i) {
        style.textContent = style.textContent + `\n.nivel_${i} {display:none}`
    }
    for (let i = nivel; i > 1; --i) {
        style.textContent = style.textContent + `\n.nivel_${i} {display:table-row}`
    }
    document.body.append(style)
}

//xover.listener.on('changed::state:checked', function ({ target: node, value }) {
//    store = node.store;
//    store.state.busy = true;
//})

//xover.listener.on('rendered', function ({ target: store }) {
//    if (store.state.busy) {
//        store.state.busy = false;
//    }
//})

function fechaLetra(date) {
    const monthNames = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
        "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"
    ];

    var parts = date.match(/(\d{1,2})(\/|-)(\d{1,2})\2(\d{4})/)
    return parts[1] + ' de ' + monthNames[parseInt(parts[3]) - 1] + ' de ' + parts[4];

}

function fncLetra(cant) {
    return numberToPesos(cant).toUpperCase();
}

function numberToPesos(qty) {
    /*Copyright: Uriel Gómez R (Panax Nation). Under MIT license*/
    const number_word =
    {
        "0": "cero"
        , "001": "un"
        , "002": "dos"
        , "003": "tres"
        , "004": "cuatro"
        , "005": "cinco"
        , "006": "seis"
        , "007": "siete"
        , "008": "ocho"
        , "009": "nueve"
        , "010": "diez"
        , "011": "once"
        , "012": "doce"
        , "013": "trece"
        , "014": "catorce"
        , "015": "quince"
        , "016": "dieciséis"
        , "020": "veinte"
        , "021": "veintión"
        , "022": "veintidós"
        , "023": "veintitrós"
        , "026": "veintiséis"
        , "030": "treinta"
        , "040": "cuarenta"
        , "050": "cincuenta"
        , "060": "sesenta"
        , "070": "setenta"
        , "080": "ochenta"
        , "090": "noventa"
        , "100": "ciento"
        , "200": "doscientos"
        , "300": "trescientos"
        , "400": "cuatrocientos"
        , "500": "quinientos"
        , "600": "seiscientos"
        , "700": "setecientos"
        , "800": "ochocientos"
        , "900": "novecientos"
        , "Y000": "mil"
        , "X000000": "millones"
        , "X000000000000": "billones"
        , "X000000000000000000": "trillones"
        , "X000000000000000000000000": "cuatrillones"
        , "X000000000000000000000000000000": "quintillones"
    } //etc

    const corrections = {
        "veinte y ": "veinti"
        , "diez y ": "dieci"
        , "un mil": "mil"
        , "un (\\w+)llones": "un $1llón"
        , "^un pesos": "un peso"
        , "ciento mil ": "cien mil "
        , "ciento pesos": "cien pesos"
        , "ciento un (\\w+)llón": "ciento un $1llones"
        , "ciento (\\w+)llones": "cien $1llones"
        , "(\\w+)llón pesos": "$1llón de pesos"
        , "(\\w+)llones pesos": "$1llones de pesos"
    }

    if (isNaN(parseFloat(qty))) {
        return ""
    }
    qty = String(qty).replace(/^0+/, '0')
    let [, current, rest, decimals] = String(qty).match(/^(\d{1,3})((?:\d{3})*)(\.\d+)?$/i);
    let statement = '';
    current = String(current).padStart(3, '0');
    let [, hundreds, tens, units] = current.match(/^(\d)(\d)(\d)$/);
    statement += ((number_word[`${hundreds}00`] || '') + ' ').replace(/^\s+/, '');
    statement += ((number_word[`0${tens}${units}`] || (number_word[`0${tens}0`] || '') + ' y') + ' ').replace(/^\s+y?\s/, '');
    statement += (((number_word[`0${tens}${units}`] ? '' : number_word[`00${units}`]) || '') + ' ').replace(/^\s+/, '');
    statement += ((!statement ? '' : number_word['Y'.padEnd((rest.length % 6) + 1, '0')] || '') + ' ').replace(/^\s+/, '');
    statement += ((number_word['X'.padEnd(rest.length - (rest.match(/^0{3}/, '') ? rest.length % 6 : 0) + 1, '0')] || '') + ' ').replace(/^\s+/, '');
    statement += numberToPesos(rest.replace(/^0+/, ''));
    if (numberToPesos.caller != numberToPesos) {
        if (!statement) {
            statement += number_word[parseInt(current)] + ' ';
        }
        statement += "pesos " + (decimals || '.00').substr(1, 2).padEnd(2, '0') + "/100 M.N.";
    }
    Object.entries(corrections).forEach(([key, value]) => {
        statement = statement.replace(new RegExp('\\b' + key + '\\b', 'ig'), value);
    })
    return statement;
}

function sortRows(header) {
    let getValue = (el) => {
        let val = el.$(`td[${index}]`).getAttribute("value") || el.$(`td[${index}]`).textContent
        return parseFloat(val) != 'NaN' && parseFloat(val) || val;
    }
    let index = header.$$("preceding-sibling::*").reduce((index, el) => { index += el.colSpan || 1; return index }, 1);
    let tbody = header.parentElement.nextElementSibling;
    tbody.replaceChildren(...[...tbody.querySelectorAll("tr")].sort((el, next) => getValue(next) >= getValue(el) ? 0 : -1))
}

async function submit(node) {
    let progress = await xo.sources["loading.xslt"].render();
    if (node.filter('//security').pop()) {
        let response = await xo.server.applyPermissions(xo.xml.createDocument(node));
        response.render()
    } else {
        return Promise.reject("No implementado")
    }
    progress.remove();
}

const blacklist = {}
blacklist.add = async function (condition) {
    try {
        let blacklist_items = xo.site.state.blacklist_items || [];
        for (let cell of selection.cells) {
            if (cell.closest('.field-description')) {
                blacklist_items.push(cell.textContent)
            } else {
                let dims = cell.select("ancestor-or-self::*/@div[1]|ancestor-or-self::*/@rs[1]|ancestor-or-self::*/@trid[1]|ancestor-or-self::*/@lid[1]|ancestor-or-self::*/@desc_poliza[1]").filter(attr => attr.value).reduce((cell, attr) => { cell[attr.name] = attr.value || ''; return cell }, {});
                blacklist_items.push(dims)
            }
        }
        selection.cells.map(cell => cell.closest('table').rows.toArray().filter(tr => (tr.querySelector('.field-description') || { textContent: {} }).textContent === cell.textContent).forEach(tr => tr.classList.add('ignorado')));
        selection.cells.forEach(cell => cell.closest('tr').classList.add('ignorado'));
        xo.site.state.blacklist_items = blacklist_items;

        //selection = blacklist.concat(selection.filter(obj => obj.fecha && (obj.cta || obj.cl || obj.indicador)));
        //xo.site.state.blacklist = selection;
        //xo.site.save();

    } catch (e) { return Promise.reject(e) }
}

blacklist.upload = async function () {
    try {
        let blacklist_items = xo.site.state.blacklist_items;
        if (!blacklist_items) return Promise.reject('No hay elementos qué guardar');
        let response = await xo.server.uploadBlacklist(xo.xml.fromJSON(blacklist_items), { headers: { "content-type": "text/xml", "x-payload-parameter-name": "@input" } });
        response.render();
    } catch (e) { return Promise.reject(e) }
}

const validation = {}
validation.download = async function () {
    try {
        let response = await xo.server.request({ command: 'fact.validaciones' });
        let entries = response.select('x:response/x:r').map(row => Object.fromEntries(row.select("div|rs|un|cta|cl|indicador|fecha|value").map(el => [el.nodeName, (el.textContent || '').trim()])));
        xo.site.state.validations = undefined;
        let validations = xo.site.state.validations || [];
        validations = entries.concat(validations);
        xo.site.state.validations = validations;
        validation.highlight();
    } catch (e) {
        return Promise.reject(e);
    }
}

validation.upload = async function () {
    try {
        let payload = xo.xml.fromJSON(xo.site.state.validations);
        let response = await xo.server.uploadValidation(payload, { headers: { "content-type": "text/xml", "x-payload-parameter-name": "@input" } });
        response.render();
    } catch (e) {
        return Promise.reject(e);
    }
}

const productividad = {}
productividad.upload = function () {
    tiempos_estandar.upload()
    ov_validadas.upload()
}

const tiempos_estandar = {}
tiempos_estandar.toJSON = function () {
    let json = xo.stores.active.select(`//tiempos/tiempo`).map(tiempo => Object.fromEntries(tiempo.attributes.toArray().filter(attr => !["xo:id"].includes(attr.name)).map(attr => [attr.name, attr.value]).concat([["creado_por", xo.session.user_login]])));
    return json
}

tiempos_estandar.toXML = function () {
    let tiempos_estandar = this.toJSON();
    let xml = xo.xml.fromJSON(tiempos_estandar);
    return xml;
}

tiempos_estandar.upload = async function () {
    try {
        let payload = this.toXML();
        let response = await xo.server.uploadStandardTimes(payload, { headers: { "content-type": "text/xml", "x-payload-parameter-name": "@input" } });
        response.render();
    } catch (e) {
        return Promise.reject(e);
    }
}

const ov_validadas = {}
ov_validadas.toJSON = function () {
    let json = xo.stores.active.select(`//ov/line[@state:selected]`).map(tiempo => Object.fromEntries(tiempo.attributes.toArray().filter(attr => ["ov", "un", "go", "gd"].includes(attr.name)).map(attr => [attr.name, attr.value]).concat([["u", xo.session.user_login]])));
    return json
}

ov_validadas.toXML = function () {
    let ov_validadas = this.toJSON();
    let xml = xo.xml.fromJSON(ov_validadas);
    return xml;
}

ov_validadas.upload = async function () {
    try {
        let payload = this.toXML();
        let response = await xo.server.uploadOVconfirmadas(payload, { headers: { "content-type": "text/xml", "x-payload-parameter-name": "@input" } });
        response.render();
    } catch (e) {
        return Promise.reject(e);
    }
}

validation.sync = async function (node) {
    await validation.download();
    await validation.upload();
}

validation.highlight = function (target) {
    target = document //xover.site.renderingTo || document;
    let default_tolerance = 0.1;
    let validations = xo.site.state.validations || [];
    for (let el of [...target.querySelectorAll(`.cell`)]) {
        let cell = el.select("ancestor-or-self::*/@div[1]|ancestor-or-self::*/@rs[1]|ancestor-or-self::*/@un[1]|ancestor-or-self::*/@cta[1]|ancestor-or-self::*/@indicador[1]|ancestor-or-self::*/@cl[1]|ancestor-or-self::*/@fecha[1]|ancestor-or-self::*/@value[1]").filter(attr => attr.value).reduce((cell, attr) => { cell[attr.name] = attr.value || ''; return cell }, {});
        if (!(cell.cta || cell.cl || cell.indicador)) continue;
        for (let validation of validations) {
            if (!(validation.cta || validation.cl || validation.indicador)) continue;
            if (cell.fecha == validation.fecha && Object.keys(validation).filter(key => !['value'].includes(key)).every(key => validation[key] == cell[key]) && Object.keys(cell).filter(key => !['value'].includes(key)).every(key => validation[key] == cell[key])) {
                if (!cell.hasOwnProperty("value")) {
                    cell["value"] = parseFloat(el.textContent.replace(/%|\$|,/g, '').replace(/\(/g, '-')) || 0;
                }
                //let cell = el.select(`${Object.keys(validation).filter(validation => !['value'].includes(validation)).map((key) => `ancestor-or-self::*/@${key}[1]`).join("|")}`).reduce((cell, attr) => { cell[attr.name] = attr.value || ''; return cell }, {});
                //let validation = matching_validations.pop();
                if (validation) {
                    el.classList.remove("valid", "invalid");
                    el.setAttribute("valid-value", validation.value);
                    let tolerance = +[default_tolerance].concat(el.select("(ancestor-or-self::*/@validation-tolerance)[1]")).pop();
                    el.classList.add(Math.abs(+parseFloat(cell.value).toFixed(4) - parseFloat(validation.value).toFixed(4)) < tolerance && 'valid' || 'invalid')
                }
            }
        }
    }
}

async function generateExcelFile(table, name) {
    let progress = await xo.sources["loading.xslt"].render();
    await xover.delay(500);
    //if (this.Interval) window.clearInterval(this.Interval);
    let _progress = 0;
    let progress_bar = progress[0].querySelector('progress');
    progress_bar.style.display = 'inline';

    //this.Interval = setInterval(function () {
    //    if (progress_bar) {
    //        progress_bar.value = _progress;
    //        console.log(_progress);
    //    }
    //}, 500);
    table = table.cloneNode(true);
    table.querySelectorAll('del,.hidden').toArray().remove();
    let set_computed_background = function (cell) {
        let border = cell.style.border;
        let backgroundColor = cell.style.backgroundColor;
        let color = cell.style.color;
        let styleSheets = document.styleSheets;
        for (let styleSheet of [...styleSheets]) {
            for (let rule of [...styleSheet.rules].filter(rule => rule.selectorText && (rule.style.border || rule.style.backgroundColor || rule.style.color) && cell.matches(rule.selectorText))) {
                if (!border && rule.style.border) {
                    cell.style.border = rule.style.border;
                }
                if (!backgroundColor && rule.style.backgroundColor) {
                    cell.style.backgroundColor = rule.style.backgroundColor;
                }
                if (!color && rule.style.color) {
                    cell.style.color = rule.style.color;
                }
            }
        }
    }
    let rows = table.getElementsByTagName("tr");
    let r = 0;
    for (let row of rows) {
        ++r;
        _progress = r / rows.length * 100;
        [...row.getElementsByTagName("td")].forEach(el => set_computed_background(el));
        if (r % (rows.length / 10) == 0) {
            progress_bar.value = _progress;
            await xover.delay(500);
        }
    }
    xo.dom.toExcel(table, name.split("?")[0])
    progress.remove();
    if (this.Interval) window.clearInterval(this.Interval);
}

xo.listener.on("mousedown", function (event) {
    if (!(event && event.buttons == 1)) return
    let parent_container = (this.closest('.validation-enabled') || this.closest('.blacklist-enabled')) && this.closest("table");
    if (!parent_container) return;
    let parent_cell = this.closest('.cell,td,th');
    if (parent_cell && parent_container && !(event && (event.ctrlKey || event.shiftKey))) {
        [...parent_container.querySelectorAll(".cell.selected svg.bi-box-arrow-up-right")].filter(svg => !parent_cell.contains(svg)).forEach(svg => { svg.remove() });
        [...parent_container.querySelectorAll(".cell.selected,.selection-begin,.selection-end")].forEach(cell => { cell.classList.remove("selected", "selection-begin", "selection-end") });
    }
    if (this.closest(".cell")) {
        this.classList.add("selected");
        this.classList.add("selection-begin");
        //console.log(event.target);
        event.stopPropagation();
        event.preventDefault();
        event.cancelBubble = true;
        event.returnValue = false;
    }
    xo.state.validate = !!(xo.state.validations || selection.cells.find(cell => cell.closest('.validation-enabled')));
    xo.state.blacklist = !!(xo.state.blacklist_items || selection.cells.find(cell => cell.closest('.blacklist-enabled')));
})

xo.listener.on("mousemove", function (event) {
    let parent_container = (this.closest('.validation-enabled') || this.closest('.blacklist-enabled')) && this.closest("table");
    if (parent_container) {
        let selection_started = parent_container.querySelector(".selection-begin");
        if (!selection_started) return;
        let selection_end = parent_container.querySelector(".selection-end");
        if (selection_end) return;
        //let classList = [...this.classList];
        //let classDomains = [...selection_started.classList].filter(cl => cl.indexOf("domain-") == 0);
        //if ((!classDomains.length || classDomains.every(cl => classList.includes(cl))) && parent_container.contains(selection_started) && !selection_end) {
        //    this.classList.add("selected");
        //}
        xo.state.validate = !!(xo.state.validations || selection.cells.find(cell => cell.closest('.validation-enabled')));
        xo.state.blacklist = !!(xo.state.blacklist_items || selection.cells.find(cell => cell.closest('.blacklist-enabled')));
        selectCells(selection_started, this);
        selection.cells.showInfo();
    }
})

xo.listener.on("mouseup", function (event) {
    if (!(this.closest('.validation-enabled') || this.closest('.blacklist-enabled'))) return;
    if (this instanceof HTMLTableCellElement && this.matches(".cell") && !(this.matches(".presupuesto"))) {
        [...this.querySelectorAll("a.auxiliar-polizas")].removeAll();
        let cell = this;
        let attributes = cell.select("ancestor-or-self::*/@div[1]|ancestor-or-self::*/@rs[1]|ancestor-or-self::*/@un[1]|ancestor-or-self::*/@cta[1]|ancestor-or-self::*/@cl[1]|ancestor-or-self::*/@fecha[1]|ancestor-or-self::*/@tipo[1]").reduce((obj, attr) => { obj['@' + attr.name] = attr.value || ''; return obj }, {})
        if (attributes["@fecha"] != '' && (attributes["@fecha"] || '').indexOf('~') == -1 && (attributes["@cta"] || attributes["@cl"]) && attributes["@rs"]) {
            if (this.closest('.presupuestos')) attributes["@tipo"] = 'presupuesto'
            let url_params = new URLSearchParams(attributes);
            let div = document.createElement('div');
            div.innerHTML = (`<a class="auxiliar-polizas" href="#polizas?${decodeURIComponent(url_params.toString())}" style="text-decoration: none; color: currentColor; margin-left: 5pt;"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-box-arrow-up-right" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M8.636 3.5a.5.5 0 0 0-.5-.5H1.5A1.5 1.5 0 0 0 0 4.5v10A1.5 1.5 0 0 0 1.5 16h10a1.5 1.5 0 0 0 1.5-1.5V7.864a.5.5 0 0 0-1 0V14.5a.5.5 0 0 1-.5.5h-10a.5.5 0 0 1-.5-.5v-10a.5.5 0 0 1 .5-.5h6.636a.5.5 0 0 0 .5-.5z"/><path fill-rule="evenodd" d="M16 .5a.5.5 0 0 0-.5-.5h-5a.5.5 0 0 0 0 1h3.793L6.146 9.146a.5.5 0 1 0 .708.708L15 1.707V5.5a.5.5 0 0 0 1 0v-5z"/></svg></a>`)
            let link = div.firstChild;
            cell.append(link);
        }
    }
    let parent_container = this.closest("table");
    if (parent_container) {
        let selection_started = parent_container.querySelector(".selection-begin");
        if (selection_started) {
            this.classList.add("selection-end");
            let offcanvas = document.querySelector('#offcanvasSelection');
            if (offcanvas) {
                new bootstrap.Offcanvas(offcanvas).toggle()
                let cells = selection.cells;
                xo.state.validate = !!(xo.state.validations || cells.find(cell => cell.closest('.validation-enabled')));
                xo.state.blacklist = !!(xo.state.blacklist_items || cells.find(cell => cell.closest('.blacklist-enabled')));
                cells.showInfo();
            }
        }
    }
})

selectCells = function (selection_started, selection_end) {
    let [ix, iy] = [selection_started.closest("td,th,table,body").cellIndex, selection_started.closest("tr,table,body").rowIndex];
    let [ex, ey] = [selection_end.closest("td,th,table,body").cellIndex, selection_end.closest("tr,table,body").rowIndex];

    if (ix > ex) [ix, ex] = [ex, ix];
    if (iy > ey) [iy, ey] = [ey, iy];

    let parent_container = selection_end.closest("table");
    let classDomains = [...selection_started.classList].filter(cl => cl.indexOf("domain-") == 0);
    parent_container && [...parent_container.querySelectorAll(".cell.selected")].forEach(cell => { cell.classList.remove("selected", "border-top", "border-right", "border-bottom", "border-left") });
    for (let r = iy; r <= ey; ++r) {
        for (let c = ix; c <= ex; ++c) {
            let row = parent_container.rows[r] || null;
            let target = row && row.cells[c] || null;
            if (!target) continue;
            let classList = target && [...target.classList];
            if ((!classDomains.length || classDomains.every(cl => classList.includes(cl))) && parent_container.contains(selection_started)) {
                target.classList.add("selected");
                if (c == ix) target.classList.add("border-left");
                if (c == ex) target.classList.add("border-right");
                if (r == iy) target.classList.add("border-top");
                if (r == ey) target.classList.add("border-bottom");
            }
        }
    }
}

let selection = {};
Object.defineProperty(selection, 'cells', {
    get: function () {
        let result = [...document.querySelectorAll(".cell.selected")];

        Object.defineProperty(result, 'showInfo', {
            value: function () {
                let selection = this;
                let target = document.forms['selection'];
                if (!target) return;

                let formatValue = function (node) {
                    let value;
                    if (!node) {
                        value = null;
                    } else if (['days'].includes(node.name)) {
                        value = new Intl.NumberFormat().format(node.value)
                    } else {
                        value = new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(node.value)
                    }
                    return value;
                }
                target.querySelector('.valor').classList.remove('d-none');
                let sum = selection.sum();
                target.valor.value = new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(sum);

                target.querySelector('.formula').classList.add('d-none');
                if (selection.length == 1) {
                    let el = selection[0];
                    let scope = el.scope;
                    let formula = el.getAttribute("formula");
                    if (formula) {
                        target.querySelector('.valor').classList.add('d-none');
                        target.querySelector('.formula').classList.remove('d-none');
                        target.querySelector('label').textContent = formula + ' = ';
                        if (scope) {
                            target.querySelector('code').innerHTML = formula.replace(/@[\w]+/g, (match) => `<var title="${match.substr(1)}">${formatValue(scope.getAttributeNode(match.substr(1)))}</var>`);
                        }
                    }
                }
            }, writable: false, configurable: false, enumerable: false
        })

        Object.defineProperty(result, 'sum', {
            value: function () {
                return this.map(el => {
                    let cell = el.select("ancestor-or-self::*/@div[1]|ancestor-or-self::*/@rs[1]|ancestor-or-self::*/@un[1]|ancestor-or-self::*/@cta[1]|ancestor-or-self::*/@indicador[1]|ancestor-or-self::*/@cl[1]|ancestor-or-self::*/@fecha[1]|ancestor-or-self::*/@value[1]").filter(attr => attr.value).reduce((cell, attr) => { cell[attr.name] = attr.value || ''; return cell }, {});

                    if (!cell.hasOwnProperty("value")) {
                        cell["value"] = parseFloat(el.textContent.replace(/%|\$|,/g, '').replace(/\(/g, '-')) || 0;
                    }
                    return parseFloat(cell["value"] || 0)
                }).filter(value => isFinite(value)).reduce((sum, item) => sum + item, 0)
            }, writable: false, configurable: false, enumerable: false
        })

        Object.defineProperty(result, 'fix', {
            value: function (valid) {
                let validations = xo.site.state.validations || [];
                let selection = this.map(el => {
                    el.classList.remove("valid", "invalid")
                    let cell = el.select("ancestor-or-self::*/@div[1]|ancestor-or-self::*/@rs[1]|ancestor-or-self::*/@un[1]|ancestor-or-self::*/@cta[1]|ancestor-or-self::*/@indicador[1]|ancestor-or-self::*/@cl[1]|ancestor-or-self::*/@fecha[1]|ancestor-or-self::*/@value[1]").filter(attr => attr.value).reduce((cell, attr) => { cell[attr.name] = attr.value || ''; return cell }, {});

                    let value;
                    if (!cell.hasOwnProperty("value")) {
                        cell["value"] = parseFloat(el.textContent.replace(/%|\$|,/g, '').replace(/\(/g, '-')) || 0;
                    }
                    if (valid) {
                        value = cell["value"];
                    } else {
                        value = prompt(`Cuál debe ser el valor para ${Object.entries(cell).reduce((values, [key, value]) => { values.push(`${key}:${value}`); return values }, []).join(', ')}`);
                    }
                    if (value != undefined) {
                        cell["value"] = parseFloat(cell["value"]).toFixed(4);
                        value = parseFloat(value).toFixed(4);
                        if (cell.fecha && (cell.cta || cell.indicador || cell.cl) && (cell.div || cell.rs)) {
                            if (value == cell["value"]) {
                                el.classList.add("valid")
                            } else {
                                el.classList.add("invalid")
                            }
                        }
                        cell["value"] = value;
                        return cell;
                    }
                }).filter(el => el);
                selection = validations.concat(selection.filter(obj => obj.fecha && (obj.cta || obj.cl || obj.indicador)));
                xo.site.state.validations = selection;
                xo.site.save();
            }, writable: false, configurable: false, enumerable: false
        })
        return result;
    }
});

xo.listener.on(`input::input[type=search]`, function (event) {
    const input = this;
    clearTimeout(input.search_timeout);
    this.search_timeout = setTimeout(() => {
        //let scope = input.scope;
        //scope.value = input.value;
        let search_text = input.value;//this.documentElement.getAttribute("state:filter");
        let inverted = search_text[0] == '!';
        search_text = search_text.replace(/^\!/, '');
        let records = this.closest('table,form').select(`.//tr/@desc_poliza|.//select/option/text()`)
        records.forEach(record => record.parentNode.classList.remove('hidden'));
        for (let attr of records.filter(desc => inverted !== !desc.value.match(new RegExp(search_text, "ig")))) {
            attr.parentNode.classList.add('hidden')
        }
        clearTimeout(input.search_timeout);
    }, 100);
});

//xo.listener.on(`beforeTransform::#polizas.xslt`, function ({ }) {
//    let search_text = this.documentElement.getAttribute("state:filter");
//    if (!search_text) return;
//    for (let attr of this.select(`*/xo:r/@desc`).filter(desc => !desc.value.match(new RegExp(search_text, "ig")))) {
//        attr.parentNode.remove({silent:true})
//    }    
//})

xo.listener.on('fetch::#concentrado_er_balance', function ({ document }) {
    document.select(`//*[contains(@fecha,'~')]/@cl`).filter(cl => ![1,2,3].includes(+cl.value[0])).map(el => el.parentNode).remove()
    document.select(`//*[@fecha][not(contains(@fecha,'~'))]/@cl`).filter(cl => [1,2,3].includes(+cl.value[0])).map(el => el.parentNode).remove()
})

xo.listener.on(`change::@state:date`, function ({ value, event }) {
    let srcElement = (event.srcEvent || event).srcElement;
    let store = srcElement.store;
    if (!store) return;
    store.source.definition["server:request"]["@month"] = value;
    store.document.fetch();
})

xo.listener.on(`fetch::#razones_financieras`, function ({ document }) {
    xo.stores.active.select(`//razones_sociales/razon_social[@state:checked]`).forEach(razon_social => document.select(`//razones_sociales/razon_social[@id="${razon_social.getAttribute("id")}"]`).forEach(target => target.setAttribute("state:checked", razon_social.getAttribute("state:checked"))));
})

xo.listener.on("fetch::xo:response", function () {
    let new_node = this.selectFirst('xo:response//model');
    new_node instanceof Element && this.documentElement.replaceWith(new_node)
})

xo.listener.on('beforeRender::html:dialog', function ({ element }) {
    if ([...document.querySelectorAll('dialog')].find(dialog => dialog.isEqualNode(element))) {
        event.preventDefault()
    }
})

xo.listener.skipSelector(".dropdown-menu.show")