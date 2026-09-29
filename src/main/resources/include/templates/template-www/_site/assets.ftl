<#-- url follows the blog contract and resolves the theme's public resources for each consumer. -->
<#macro head url _res={}>
    <link href="${url?html}/fonts/remixicon.css" rel="stylesheet"/>
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
                        'display': ['clamp(2rem, 4vw, 3.5rem)', {lineHeight: '1.2', fontWeight: '500'}],
                        'page-title': ['clamp(1.75rem, 3vw, 2.5rem)', {lineHeight: '1.25', fontWeight: '500'}],
                        'headline': ['1.5rem', {lineHeight: '1.35', fontWeight: '500'}],
                        'title': ['1.125rem', {lineHeight: '1.5', fontWeight: '500'}],
                        'label': ['0.875rem', {lineHeight: '1.25rem', fontWeight: '500'}]
                    },
                    transitionTimingFunction: {standard: 'cubic-bezier(0.2, 0, 0, 1)'}
                }
            }
        };
    </script>
</#macro>
