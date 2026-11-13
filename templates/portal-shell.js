(() => {
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

    xo.listener.on('shell:print', () => window.print());

    xo.listener.on('shell:logout', async function ({ target }) {
        target.disabled = true;
        try {
            await xo.session.logout();
        } catch (error) {
            xo.dom.alert(error.message);
        } finally {
            target.disabled = false;
        }
    });

    xo.listener.on('render', () => requestAnimationFrame(syncPortalHeader));
    xo.listener.on('hashchange', () => {
        document.querySelector('#shell')?.dispatch('shell:sitemap', { open: false });
        requestAnimationFrame(syncPortalHeader);
    });
    document.addEventListener('keydown', event => {
        if (event.key === 'Escape' && document.querySelector('#shell.sitemap-expanded')) {
            document.querySelector('#shell').dispatch('shell:sitemap', { open: false });
            document.querySelector('[aria-controls="sitemap"]')?.focus();
        }
    });
})();
