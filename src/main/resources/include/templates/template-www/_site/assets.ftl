<#-- url follows the blog contract and resolves the theme's public resources for each consumer. -->
<#macro head url _res={}>
    <link href="${url?html}/fonts/material-symbols-rounded.woff2" rel="preload" as="font" type="font/woff2" crossorigin/>
    <link href="${url?html}/fonts/material-symbols.css" rel="stylesheet"/>
    <link href="${url?html}/css/site-shell.css" rel="stylesheet"/>
    <link href="${url?html}/css/site-content.css" rel="stylesheet"/>
    <style>:root { --color-primary: ${(_res.colorPrimary?has_content)?then(_res.colorPrimary, '#1677ff')?html}; }</style>
    <script src="${url?html}/js/site-theme.js"></script>
    <script src="${url?html}/js/tailwindcss-3.4.6.js"></script>
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    colors: {
                        primary: 'var(--site-primary)', 'on-primary': 'var(--site-on-primary)',
                        link: 'var(--site-link)',
                        'primary-container': 'var(--site-tint)', 'on-primary-container': 'var(--site-on-tint)',
                        'secondary-container': 'var(--site-secondary-container)', 'on-secondary-container': 'var(--site-on-secondary-container)',
                        'tertiary-container': 'var(--site-tertiary-container)', 'on-tertiary-container': 'var(--site-on-tertiary-container)',
                        error: 'var(--site-error)', 'error-container': 'var(--site-error-container)',
                        success: 'var(--site-success)', 'success-container': 'var(--site-success-container)',
                        surface: 'var(--site-paper)', 'on-surface': 'var(--site-ink)',
                        'on-surface-variant': 'var(--site-muted)',
                        'surface-container': 'var(--site-container)',
                        'surface-container-high': 'var(--site-soft)',
                        'surface-container-highest': 'var(--site-container-highest)',
                        outline: 'var(--site-outline)', 'outline-variant': 'var(--site-line)',
                        // Legacy extension accent; M3 controls use paired semantic roles above.
                        secondary: '#f97316'
                    },
                    borderRadius: {
                        'none': '0px', 'sm': '4px', DEFAULT: '8px', 'md': '12px',
                        'lg': '16px', 'xl': '20px', '2xl': '24px', '3xl': '32px', 'full': '9999px',
                        'button': 'var(--site-shape-full)', 'card': 'var(--site-radius)',
                        'field': 'var(--site-shape-xs)', 'chip': 'var(--site-shape-sm)'
                    },
                    fontSize: {
                        'display': ['clamp(2.5rem, 5vw, 4.5rem)', {lineHeight: '1.12', fontWeight: '600'}],
                        'page-title': ['clamp(2rem, 4vw, 3.25rem)', {lineHeight: '1.2', fontWeight: '600'}],
                        'headline': ['1.5rem', {lineHeight: '1.35', fontWeight: '500'}],
                        'section-title': ['clamp(1.75rem, 3vw, 2.25rem)', {lineHeight: '1.3', fontWeight: '600'}],
                        'title': ['1.125rem', {lineHeight: '1.5', fontWeight: '500'}],
                        'label': ['0.875rem', {lineHeight: '1.25rem', fontWeight: '500'}]
                    },
                    transitionTimingFunction: {standard: 'cubic-bezier(0.2, 0, 0, 1)'}
                }
            }
        };
    </script>
</#macro>
