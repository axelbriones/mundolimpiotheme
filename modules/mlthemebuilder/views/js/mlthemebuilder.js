/**
 * MlThemeBuilder - Main Theme Builder JS (if needed for specific admin interactions not covered by admin.js)
 * This file could be used for more complex UI interactions within the Theme Builder configuration page
 * that are specific to the overall "builder" experience, rather than generic CRUD for items.
 *
 * For now, most of the logic is in admin.js. This file is a placeholder or for future expansion.
 */

$(document).ready(function() {
    console.log('MlThemeBuilder main JS file loaded (mlthemebuilder.js)');

    // Example: Initialize a more complex UI component if one existed
    // if (typeof MyThemeBuilderUIComponent !== 'undefined') {
    //     MyThemeBuilderUIComponent.init();
    // }

    // Example: Event delegation for dynamically added elements if not covered by admin.js handlers
    // $('#mlthemebuilder-config').on('click', '.some-dynamic-button', function() {
    //     // ... handle click ...
    // });
});
