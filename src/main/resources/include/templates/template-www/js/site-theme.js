// Run in <head> so both hosts apply the saved/system theme before painting.
(() => {
    const root = document.documentElement;
    const systemTheme = window.matchMedia('(prefers-color-scheme: dark)');
    // Surface roles follow @zrlog/ui/material (material-colors.ts), without its
    // React/Ant Design runtime. Light filled actions preserve the configured
    // brand exactly; text links have their own contrast-adjusted role. Not HCT.
    const mix = (color, other, amount) => color.map((channel, i) => Math.round(channel + (other[i] - channel) * amount));
    const white = [255, 255, 255];
    const black = [0, 0, 0];
    const gray = (value) => [value, value, value];
    const luminance = (color) => color.map((value) => {
        const c = value / 255;
        return c <= 0.04045 ? c / 12.92 : ((c + 0.055) / 1.055) ** 2.4;
    }).reduce((sum, value, i) => sum + value * [0.2126, 0.7152, 0.0722][i], 0);
    const contrast = (a, b) => (Math.max(luminance(a), luminance(b)) + 0.05) / (Math.min(luminance(a), luminance(b)) + 0.05);
    const context = document.createElement('canvas').getContext('2d', {willReadFrequently: true});
    context.fillStyle = '#1677ff';
    context.fillStyle = getComputedStyle(root).getPropertyValue('--color-primary').trim() || '#1677ff';
    context.fillRect(0, 0, 1, 1);
    const brand = Array.from(context.getImageData(0, 0, 1, 1).data).slice(0, 3);
    const palette = (dark) => {
        const surface = mix(brand, gray(dark ? 17 : 252), 0.97);
        const containerHighest = mix(brand, gray(dark ? 51 : 232), 0.96);
        const primaryContainer = mix(brand, dark ? black : white, dark ? 0.7 : 0.85);
        let link = dark ? mix(brand, white, 0.68) : brand;
        // Adjust text against the darkest light / lightest dark reading surface,
        // without silently changing the user's configured filled action color.
        for (let i = 0; i < 100 && [
            [link, primaryContainer], [link, containerHighest]
        ].some(([a, b]) => contrast(a, b) < 4.5); i++) {
            link = mix(link, dark ? white : black, 0.05);
        }
        const primary = dark ? link : brand;
        // Light filled actions use the requested brand treatment: exact seed
        // with white labels. Dark mode keeps its independently paired foreground.
        const onPrimary = !dark || contrast(primary, white) >= 4.5 ? white : black;
        // Prefer the on-color state layer when it keeps labels readable. Near
        // the contrast threshold, mix in the opposite direction instead.
        const stateColor = contrast(mix(primary, onPrimary, 0.12), onPrimary) >= 4.5
            ? onPrimary : (onPrimary === white ? black : white);
        return {
            primary, link, 'on-primary': onPrimary,
            'primary-hover': mix(primary, stateColor, 0.08),
            'primary-active': mix(primary, stateColor, 0.12),
            'primary-container': primaryContainer,
            'on-primary-container': mix(brand, dark ? white : black, dark ? 0.9 : 0.8),
            surface, container: mix(brand, gray(dark ? 28 : 255), 0.98),
            'container-high': mix(brand, gray(dark ? 40 : 241), 0.96),
            'container-highest': containerHighest,
            'on-surface': mix(brand, gray(dark ? 230 : 28), 0.94),
            'on-surface-variant': mix(brand, gray(dark ? 197 : 73), 0.94),
            outline: mix(brand, gray(dark ? 148 : 119), 0.95),
            'outline-variant': mix(brand, gray(dark ? 71 : 204), 0.96)
        };
    };
    const palettes = {light: palette(false), dark: palette(true)};
    let preference;
    try { preference = localStorage.getItem('theme'); } catch (ignored) {}

    const applyTheme = () => {
        const isDark = preference === 'dark' || (!preference && systemTheme.matches);
        root.classList.toggle('dark', isDark);
        root.style.colorScheme = isDark ? 'dark' : 'light';
        Object.entries(palettes[isDark ? 'dark' : 'light']).forEach(([role, value]) => {
            root.style.setProperty('--site-color-' + role, 'rgb(' + value.join(' ') + ')');
        });
        document.querySelectorAll('[data-theme-stylesheet]').forEach((sheet) => {
            sheet.media = sheet.dataset.themeStylesheet === (isDark ? 'dark' : 'light') ? 'all' : 'not all';
        });
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
