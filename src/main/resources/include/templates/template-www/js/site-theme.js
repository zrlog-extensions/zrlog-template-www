// Run in <head> so both hosts apply the saved/system theme before painting.
(() => {
    const root = document.documentElement;
    const systemTheme = window.matchMedia('(prefers-color-scheme: dark)');
    let preference;
    try { preference = localStorage.getItem('theme'); } catch (ignored) {}

    const applyTheme = () => {
        const isDark = preference === 'dark' || (!preference && systemTheme.matches);
        root.classList.toggle('dark', isDark);
        document.querySelectorAll('[data-theme-icon]').forEach((icon) => {
            icon.className = isDark ? 'ri-sun-line text-lg' : 'ri-moon-line text-lg';
        });
        document.querySelectorAll('[data-theme-button]').forEach((button) => {
            button.setAttribute('aria-pressed', String(isDark));
        });
    };
    applyTheme();
    document.addEventListener('DOMContentLoaded', applyTheme);
    document.addEventListener('click', (event) => {
        if (!event.target.closest('[data-theme-button]')) return;
        preference = root.classList.contains('dark') ? 'light' : 'dark';
        try { localStorage.setItem('theme', preference); } catch (ignored) {}
        applyTheme();
    });
    if (systemTheme.addEventListener) systemTheme.addEventListener('change', applyTheme);
    else if (systemTheme.addListener) systemTheme.addListener(applyTheme);
    window.addEventListener('storage', (event) => {
        if (event.key === 'theme' || event.key === null) {
            preference = event.newValue;
            applyTheme();
        }
    });
})();
