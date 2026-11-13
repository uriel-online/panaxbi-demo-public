// Adaptado de Neibora widgets/shell/shell.js.
function togglePortalSitemap(show) {
    let sidebar = document.querySelector('#shell > #sitemap');
    if (!sidebar) return
    let width = Number.parseInt(sidebar.style.width);
    let shown = !!width || show === false;
    if (!shown && document.querySelector('.report-loader')) return;
    sidebar.closest('.wrapper').classList.toggle('sitemap_collapsed', shown)
    sidebar.closest('.wrapper').classList.toggle('sitemap-collapsed', shown)
    sidebar.closest('.wrapper').classList.toggle('sitemap-expanded', !shown)
    document.querySelector('[aria-controls="sitemap"]')?.setAttribute('aria-expanded', String(!shown));
    sidebar.style.width = shown ? '0px' : '100%';
}

function syncPortalHeader() {
    const heading = document.querySelector('.portal-shell-title h1');
    if (heading) {
        const route = location.hash.split('?')[0];
        const links = document.querySelectorAll('#sitemap a[href]');
        const report = Array.from(links).find(link => link.getAttribute('href') === route);
        const title = report?.textContent.trim() || 'Panax BI';
        if (heading.textContent !== title) heading.textContent = title;
    }
    const actions = document.querySelector('.portal-report-actions');
    if (actions) actions.hidden = !document.querySelector('#shell main table');
}

window.addEventListener('beforeprint', () => {
    const table = document.querySelector('#shell .taxan-report .excel-sheet');
    if (!table) return;
    // Letter landscape with half-inch margins leaves ten inches for the table.
    const printableWidth = 10 * 96;
    table.style.removeProperty('--taxan-print-scale');
    if (table.offsetWidth > printableWidth) {
        table.style.setProperty('--taxan-print-scale', printableWidth / table.offsetWidth);
    }
});

async function runPortalAction(action, button) {
    try {
        if (action === 'logout') {
            button.disabled = true;
            await xo.session.logout();
        } else if (action === 'print') {
            window.print();
        } else if (action === 'export') {
            const table = document.querySelector('#shell main table');
            if (table) await generateExcelFile(table, xo.stores.active.tag);
        }
    } catch (error) {
        xo.dom.alert(error.message);
    } finally {
        if (button) button.disabled = false;
    }
}

xo.listener.on('render', () => requestAnimationFrame(syncPortalHeader));
xo.listener.on('hashchange', () => {
    togglePortalSitemap(false);
    requestAnimationFrame(syncPortalHeader);
});
document.addEventListener('click', event => {
    if (!event.target.closest('#sitemap, [aria-controls="sitemap"]')) togglePortalSitemap(false);
});
document.addEventListener('keydown', event => {
    if (event.key === 'Escape' && document.querySelector('#shell.sitemap-expanded')) {
        togglePortalSitemap(false);
        document.querySelector('[aria-controls="sitemap"]')?.focus();
    }
});
