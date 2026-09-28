<#-- url follows the blog template contract and points to the consumer's local copy of the public CSS/JS/fonts. -->
<#macro head url _res={}>
    <link href="${url?html}/fonts/remixicon.css" rel="stylesheet"/>
    <link href="${url?html}/css/site-shell.css" rel="stylesheet"/>
    <style>:root { --color-primary: ${(_res.colorPrimary!'#1677ff')?html}; }</style>
    <script src="${url?html}/js/site-theme.js"></script>
    <script src="${url?html}/js/tailwindcss-3.4.6.js"></script>
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    colors: {primary: 'var(--color-primary)', secondary: '#f97316'},
                    borderRadius: {
                        'none': '0px', 'sm': '4px', DEFAULT: '8px', 'md': '12px',
                        'lg': '16px', 'xl': '20px', '2xl': '24px', '3xl': '32px',
                        'full': '9999px', 'button': '8px'
                    }
                }
            }
        };
    </script>
</#macro>
