(() => {
        const openButton = document.getElementById('toggleSidebar');
        const closeButton = document.getElementById('closeSidebar');
        const sidebar = document.getElementById('sidebar');
        const overlay = document.getElementById('overlay');
        let sidebarHideTimer;
        let sidebarOpen = false;
        let previousBodyOverflow = '';
        let backgroundElements = [];
        const focusableSelector = 'a[href], button:not([disabled]), input:not([disabled]), select:not([disabled]), textarea:not([disabled]), [tabindex]:not([tabindex="-1"])';
        const sidebarFocusableElements = () => sidebar ? Array.from(sidebar.querySelectorAll(focusableSelector)) : [];
        const setBackgroundInert = (inert) => {
            if (inert) {
                backgroundElements = Array.from(document.body.children).filter((element) =>
                    element !== sidebar && element !== overlay && element.tagName !== 'SCRIPT');
                backgroundElements.forEach((element) => {
                    if (!element.hasAttribute('inert')) {
                        element.dataset.sidebarInert = 'true';
                        element.inert = true;
                    }
                });
                return;
            }
            backgroundElements.forEach((element) => {
                if (element.dataset.sidebarInert === 'true') {
                    element.inert = false;
                    delete element.dataset.sidebarInert;
                }
            });
            backgroundElements = [];
        };
        const closeSidebar = () => {
            if (!sidebarOpen || !sidebar || !overlay) return;
            const wasOpen = sidebarOpen;
            sidebarOpen = false;
            window.clearTimeout(sidebarHideTimer);
            sidebar.classList.add('-translate-x-full');
            sidebar.setAttribute('aria-hidden', 'true');
            overlay.classList.add('hidden');
            if (openButton) openButton.setAttribute('aria-expanded', 'false');
            setBackgroundInert(false);
            document.body.style.overflow = previousBodyOverflow;
            sidebarHideTimer = window.setTimeout(() => {
                sidebar.classList.add('hidden');
                if (wasOpen && openButton) openButton.focus();
            }, 300);
        };
        const openSidebar = () => {
            if (sidebarOpen || !sidebar || !overlay) return;
            window.clearTimeout(sidebarHideTimer);
            sidebarOpen = true;
            previousBodyOverflow = document.body.style.overflow;
            setBackgroundInert(true);
            document.body.style.overflow = 'hidden';
            sidebar.classList.remove('hidden');
            sidebar.setAttribute('aria-hidden', 'false');
            overlay.classList.remove('hidden');
            if (openButton) openButton.setAttribute('aria-expanded', 'true');
            window.requestAnimationFrame(() => {
                sidebar.classList.remove('-translate-x-full');
                if (closeButton) closeButton.focus();
            });
        };
        if (openButton) openButton.addEventListener('click', openSidebar);
        if (closeButton) closeButton.addEventListener('click', closeSidebar);
        if (overlay) overlay.addEventListener('click', closeSidebar);
        window.addEventListener('resize', () => {
            if (window.matchMedia('(min-width: 1280px)').matches) closeSidebar();
        });
        document.addEventListener('keydown', (event) => {
            if (!sidebarOpen) return;
            if (event.key === 'Escape') {
                event.preventDefault();
                closeSidebar();
                return;
            }
            if (event.key !== 'Tab') return;
            const focusableElements = sidebarFocusableElements();
            if (!focusableElements.length) {
                event.preventDefault();
                return;
            }
            const firstElement = focusableElements[0];
            const lastElement = focusableElements[focusableElements.length - 1];
            if (event.shiftKey && (document.activeElement === firstElement || !sidebar.contains(document.activeElement))) {
                event.preventDefault();
                lastElement.focus();
            } else if (!event.shiftKey && (document.activeElement === lastElement || !sidebar.contains(document.activeElement))) {
                event.preventDefault();
                firstElement.focus();
            }
        });
        document.addEventListener('focusin', (event) => {
            if (sidebarOpen && sidebar && !sidebar.contains(event.target)) {
                const focusableElements = sidebarFocusableElements();
                if (focusableElements.length) focusableElements[0].focus();
            }
        });

        const backToTop = document.getElementById('back-to-top');
        if (backToTop) {
            const syncBackToTop = () => {
                const visible = window.scrollY > 320;
                backToTop.classList.toggle('opacity-0', !visible);
                backToTop.classList.toggle('invisible', !visible);
            };
            window.addEventListener('scroll', syncBackToTop, {passive: true});
            backToTop.addEventListener('click', () => window.scrollTo({top: 0, behavior: window.matchMedia('(prefers-reduced-motion: reduce)').matches ? 'instant' : 'smooth'}));
            syncBackToTop();
        }

})();
