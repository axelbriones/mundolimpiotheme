/**
 * MlThemeBuilder - Admin JavaScript
 * Handles interactions within the module's configuration page in PrestaShop Back Office.
 */

// Ensure ctb_translations is defined (should be via Media::addJsDef in controller)
var ctb_translations = window.ctb_translations || {}; // Fallback to empty object

$(document).ready(function() {
    // Initialize jQuery UI Sortable for sections list
    initializeSortable('#sections-list', 'UpdateSectionOrder', 'id_mltheme_section', ctb_translations.orderUpdated, ctb_translations.errorUpdatingOrder);
    initializeSortable('#services-list', 'UpdateServiceOrder', 'id_mltheme_service', ctb_translations.orderUpdated, ctb_translations.errorUpdatingOrder);
    initializeSortable('#brands-list', 'UpdateBrandOrder', 'id_mltheme_brand', ctb_translations.orderUpdated, ctb_translations.errorUpdatingOrder);

    // --- Sections Management ---
    // Add new section
    $('#addNewSectionForm').on('submit', function(e) {
        e.preventDefault();
        const formData = $(this).serializeArray();
        let dataToSend = {
            ajax: true,
            action: 'AddSection',
            new_section_name: formData.find(item => item.name === 'new_section_name').value,
            new_section_type: formData.find(item => item.name === 'new_section_type').value,
            new_section_title: {}
        };
        formData.filter(item => item.name.startsWith('new_section_title')).forEach(item => {
            const langId = item.name.match(/\[(\d+)\]/)[1];
            dataToSend.new_section_title[langId] = item.value;
        });

        $.post(ctb_ajax_url, dataToSend, function(response) {
            if (response.success && response.section) {
                addSectionItemToDOM(response.section);
                $('#addNewSectionForm')[0].reset();
                showSuccessMessage(response.message || ctb_translations.itemAdded);
            } else {
                showErrorMessage(response.message || ctb_translations.errorSavingConfig);
            }
        }, 'json').fail(function() {
            showErrorMessage(ctb_translations.errorSavingConfig + ' (AJAX Error)');
        });
    });

    // Configure Section Button
    $('body').on('click', '.configure-section-btn', function() {
        const sectionId = $(this).data('id');
        const sectionType = $(this).data('type');
        $('#sectionModalLabel').text((ctb_translations.configureSection || 'Configure Section') ); // Default text
        $('#section-modal-form-content').html('<p class="text-center"><i class="icon-spinner icon-spin"></i> ' + (ctb_translations.loading || 'Loading...') + '</p>');
        $('#sectionConfigurationModal').modal('show');

        $.post(ctb_ajax_url, {
            ajax: true,
            action: 'GetSectionForm',
            id_mltheme_section: sectionId
        }, function(response) {
            if (response.success) {
                $('#section-modal-form-content').html(response.form_html);
                $('#sectionModalLabel').text((ctb_translations.configureSection || 'Configure Section') + ': ' + response.section_name);
                // Initialize any JS needed for the loaded form (e.g., color pickers, RTEs)
                if (typeof initColorPicker !== 'undefined') initColorPicker(); // If you have a global color picker init
                if (typeof tinyMCE !== 'undefined' && typeof tinyMCE.init !== 'undefined') { // Check if TinyMCE is loaded
                    // Example: $('textarea.rte').tinymce({...}); // Initialize RTEs if any
                }
                 // Initialize Bootstrap tabs if they are part of the loaded form
                $('#section-modal-form-content .nav-tabs a').click(function (e) {
                    e.preventDefault();
                    $(this).tab('show');
                });
                // Make sure the first tab is active if it's a tabbed form
                $('#section-modal-form-content .nav-tabs li:first-child a').tab('show');


            } else {
                $('#section-modal-form-content').html('<div class="alert alert-danger">' + (response.message || ctb_translations.errorLoadingForm) + '</div>');
            }
        }, 'json').fail(function() {
             $('#section-modal-form-content').html('<div class="alert alert-danger">' + (ctb_translations.errorLoadingForm || 'Error loading form.') + ' (AJAX Error)</div>');
        });
    });

    // Save Section Configuration (from Modal)
    $('#saveSectionConfiguration').on('click', function() {
        const form = $('#section-modal-form-content form'); // Assuming form is loaded into this div
        if (!form.length) {
             showErrorMessage('Configuration form not found in modal.');
             return;
        }
        const formData = form.serializeArray(); // Get all form data
        let dataToSend = {
            ajax: true,
            action: 'SaveSectionConfig',
            id_mltheme_section: formData.find(item => item.name === 'id_mltheme_section')?.value || $('#section_id').val() // Fallback if id_mltheme_section is hidden input with id="section_id"
        };

        // Organize multilingual fields and config fields
        let configFields = {};
        let titleFields = {};
        let contentFields = {};
        let buttonTextFields = {};
        let buttonLinkFields = {};

        formData.forEach(item => {
            if (item.name.startsWith('config[')) {
                // Extract actual key: config[key][lang_id] or config[key]
                const keyMatch = item.name.match(/^config\[([^\]]+)\](?:\[(\d+)\])?/);
                if (keyMatch) {
                    const mainKey = keyMatch[1];
                    const langId = keyMatch[2];
                    if (langId) {
                        if (!configFields[mainKey]) configFields[mainKey] = {};
                        configFields[mainKey][langId] = item.value;
                    } else {
                        configFields[mainKey] = item.value;
                    }
                }
            } else if (item.name.startsWith('title[')) {
                const langId = item.name.match(/\[(\d+)\]/)[1];
                titleFields[langId] = item.value;
            } else if (item.name.startsWith('content[')) {
                const langId = item.name.match(/\[(\d+)\]/)[1];
                contentFields[langId] = item.value;
            } else if (item.name.startsWith('button_text[')) {
                const langId = item.name.match(/\[(\d+)\]/)[1];
                buttonTextFields[langId] = item.value;
            } else if (item.name.startsWith('button_link[')) {
                const langId = item.name.match(/\[(\d+)\]/)[1];
                buttonLinkFields[langId] = item.value;
            } else if (item.name !== 'id_mltheme_section') { // Avoid duplicating id if it's not in config
                 dataToSend[item.name] = item.value; // Other direct fields
            }
        });
        dataToSend.config = configFields;
        dataToSend.title = titleFields;
        dataToSend.content = contentFields;
        dataToSend.button_text = buttonTextFields;
        dataToSend.button_link = buttonLinkFields;

        $.post(ctb_ajax_url, dataToSend, function(response) {
            if (response.success) {
                $('#sectionConfigurationModal').modal('hide');
                showSuccessMessage(response.message || ctb_translations.configSaved);
                // Optionally, update the section item in the list if display name changed
                // This requires fetching the updated section name or having it in response
            } else {
                showErrorMessage(response.message || ctb_translations.errorSavingConfig);
            }
        }, 'json').fail(function() {
            showErrorMessage(ctb_translations.errorSavingConfig + ' (AJAX Error)');
        });
    });

    // Toggle Section Status
    $('body').on('change', '.section-status-toggle input[type="radio"]', function() {
        const sectionId = $(this).closest('.section-item').data('id');
        const isActive = $(this).val() == '1';
        $.post(ctb_ajax_url, {
            ajax: true,
            action: 'ToggleSectionStatus',
            id_mltheme_section: sectionId,
            active: isActive ? 1 : 0
        }, function(response) {
            if (response.success) {
                showSuccessMessage(response.message || ctb_translations.statusUpdated);
            } else {
                showErrorMessage(response.message || ctb_translations.errorUpdatingStatus);
                // Revert switch if error
                $(this).prop('checked', !isActive);
                $(this).siblings('input[type="radio"]').prop('checked', isActive);

            }
        }, 'json').fail(function() {
            showErrorMessage(ctb_translations.errorUpdatingStatus + ' (AJAX Error)');
            $(this).prop('checked', !isActive);
            $(this).siblings('input[type="radio"]').prop('checked', isActive);
        });
    });

    // Delete Section
    $('body').on('click', '.delete-section-btn', function() {
        if (!confirm(ctb_translations.confirmDeleteSection || 'Are you sure you want to delete this section?')) return;
        const sectionItem = $(this).closest('.section-item');
        const sectionId = sectionItem.data('id');
        $.post(ctb_ajax_url, {
            ajax: true,
            action: 'DeleteSection',
            id_mltheme_section: sectionId
        }, function(response) {
            if (response.success) {
                sectionItem.fadeOut(300, function() { $(this).remove(); });
                showSuccessMessage(response.message || ctb_translations.sectionDeleted);
            } else {
                showErrorMessage(response.message || ctb_translations.errorDeletingSection);
            }
        }, 'json').fail(function() {
            showErrorMessage(ctb_translations.errorDeletingSection + ' (AJAX Error)');
        });
    });


    // --- Services Management --- (Similar structure to Sections)
    handleCRUDOperations({
        listSelector: '#services-list',
        itemSelector: '.service-item',
        formSelector: '#serviceForm',
        submitButtonTextSelector: '#serviceSubmitButtonText',
        cancelButtonSelector: '#cancelEditService',
        titleSelector: '#serviceFormTitle',
        hiddenIdField: '#id_service',
        deleteButtonClass: '.delete-service-btn',
        editButtonClass: '.edit-service-btn',
        statusToggleClass: '.service-status-toggle',
        templateId: '#newServiceItemTemplate',
        actions: {
            add: 'SaveService', // SaveService handles both add and update
            update: 'SaveService',
            delete: 'DeleteService',
            get: 'GetService',
            toggleStatus: 'ToggleServiceStatus'
        },
        idKey: 'id_mltheme_service',
        nameKeyForTitle: 'title_default', // Key in response object to use for title
        nameKeyForTemplate: 'title', // Key in response object to use for template {title} placeholder
        confirmDeleteMsg: ctb_translations.confirmDeleteService || 'Are you sure you want to delete this service?',
        itemAddedMsg: ctb_translations.itemAdded || 'Service added.',
        itemSavedMsg: ctb_translations.itemSaved || 'Service saved.',
        itemDeletedMsg: ctb_translations.serviceDeleted || 'Service deleted.',
        addTitle: ctb_translations.addServiceTitle || 'Add New Service',
        editTitlePrefix: ctb_translations.editServiceTitlePrefix || 'Edit Service: ',
        addButtonText: ctb_translations.addServiceBtn || 'Add Service',
        saveButtonText: ctb_translations.saveServiceBtn || 'Save Service',
        populateFormFunction: function(form, data) { // Custom populator for services
            form.find('#id_service').val(data.id_mltheme_service);
            form.find('#service_icon').val(data.icon).trigger('change'); // Trigger change for preview
            form.find('input[name="active"][value="' + (data.active ? '1':'0') + '"]').prop('checked', true);

            // Populate multilingual fields
            for (const langId in data.title) {
                form.find('#service_title_' + langId).val(data.title[langId]);
            }
            for (const langId in data.description) {
                form.find('#service_description_' + langId).val(data.description[langId]);
            }
            // Show the current default language fields
            if (typeof showServiceLangField === 'function') { // Assuming showServiceLangField exists
                showServiceLangField(currentServiceLang || default_language);
            }
        },
        getTemplateDataFunction: function(responseItem) {
            let iconHtml = '<i class="icon-star"></i>'; // Default
            if (responseItem.icon) {
                if (responseItem.icon.startsWith('fa-') || responseItem.icon.startsWith('fas ') || responseItem.icon.startsWith('far ') || responseItem.icon.startsWith('fab ')) {
                    iconHtml = '<i class="' + responseItem.icon + ' fa-lg"></i>';
                } else {
                    iconHtml = '<img src="' + ctb_theme_img_path + 'icons/' + responseItem.icon + '?rand='+Math.random()+'" alt="" style="max-height: 20px; max-width:20px;"/>';
                }
            }
            return {
                id: responseItem.id_mltheme_service,
                icon_html: iconHtml,
                title: responseItem.titles ? (responseItem.titles[default_language] || responseItem.titles[Object.keys(responseItem.titles)[0]] || 'Service') : 'Service',
                active_on_checked: responseItem.active ? 'checked="checked"' : '',
                active_off_checked: !responseItem.active ? 'checked="checked"' : ''
            };
        }
    });

    // Icon Manager Modal for Services
    $('#openIconManager').on('click', function(e) {
        e.preventDefault();
        loadUploadedIcons();
        $('#iconManagerModal').modal('show');
    });

    $('#uploadIconForm').on('submit', function(e) {
        e.preventDefault();
        var formData = new FormData(this);
        formData.append('ajax', true);
        formData.append('action', 'UploadServiceIcon'); // Or a generic 'UploadIcon' if used elsewhere

        $.ajax({
            url: ctb_ajax_url, // Make sure ctb_ajax_url is defined
            type: 'POST',
            data: formData,
            contentType: false,
            processData: false,
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    showSuccessMessage(response.message || ctb_translations.imgUploadSuccess);
                    loadUploadedIcons(); // Refresh list
                    // Optionally set the icon field if a context is known
                    $('#service_icon').val(response.filename).trigger('change');
                    $('#iconManagerModal').modal('hide');
                } else {
                    showErrorMessage(response.message || ctb_translations.imgUploadError);
                }
            },
            error: function() {
                showErrorMessage(ctb_translations.imgUploadError + ' (AJAX Error)');
            }
        });
    });

    $('body').on('click', '#uploadedIconsList .uploaded-icon-item', function() {
        var iconFilename = $(this).data('filename');
        $('#service_icon').val(iconFilename).trigger('change');
        $('#iconManagerModal').modal('hide');
    });


    // --- Brands Management ---
    handleCRUDOperations({
        listSelector: '#brands-list',
        itemSelector: '.brand-item-admin',
        formSelector: '#brandForm',
        submitButtonTextSelector: '#brandSubmitButtonText',
        cancelButtonSelector: '#cancelEditBrand',
        titleSelector: '#brandFormTitle',
        hiddenIdField: '#id_brand',
        deleteButtonClass: '.delete-brand-btn',
        editButtonClass: '.edit-brand-btn',
        statusToggleClass: '.brand-status-toggle',
        templateId: '#newBrandItemTemplate',
        actions: {
            add: 'SaveBrand',
            update: 'SaveBrand',
            delete: 'DeleteBrand',
            get: 'GetBrand',
            toggleStatus: 'ToggleBrandStatus'
        },
        idKey: 'id_mltheme_brand',
        nameKeyForTitle: 'name',
        nameKeyForTemplate: 'name',
        confirmDeleteMsg: ctb_translations.confirmDeleteBrand || 'Are you sure you want to delete this brand?',
        itemAddedMsg: ctb_translations.itemAdded || 'Brand added.',
        itemSavedMsg: ctb_translations.itemSaved || 'Brand saved.',
        itemDeletedMsg: ctb_translations.brandDeleted || 'Brand deleted.',
        addTitle: ctb_translations.addBrandTitle || 'Add New Brand',
        editTitlePrefix: ctb_translations.editBrandTitlePrefix || 'Edit Brand: ',
        addButtonText: ctb_translations.addBrandBtn || 'Add Brand',
        saveButtonText: ctb_translations.saveBrandBtn || 'Save Brand',
        populateFormFunction: function(form, data) {
            form.find('#id_brand').val(data.id_mltheme_brand);
            form.find('#brand_name').val(data.name);
            form.find('#brand_url').val(data.url);
            form.find('input[name="active"][value="' + (data.active ? '1':'0') + '"]').prop('checked', true);
            form.find('#current_logo').val(data.logo || '');
            if (data.logo_url) {
                form.find('#brand_logo_preview_img').attr('src', data.logo_url + '?rand=' + Math.random()).show();
                form.find('#brand_logo_preview_container').show();
                form.find('#removeBrandLogoBtn').show();
            } else {
                form.find('#brand_logo_preview_img').hide();
                 form.find('#brand_logo_preview_container').hide();
                form.find('#removeBrandLogoBtn').hide();
            }
        },
        getTemplateDataFunction: function(responseItem) {
            let logoHtml = '<i class="icon-picture"></i>';
            if (responseItem.logo_url) {
                logoHtml = '<img src="' + responseItem.logo_url + '?rand='+Math.random()+'" alt="' + responseItem.name + '" style="max-height: 24px; max-width: 80px; border:1px solid #ddd;"/>';
            }
            return {
                id: responseItem.id_mltheme_brand,
                logo_html: logoHtml,
                name: responseItem.name,
                active_on_checked: responseItem.active ? 'checked="checked"' : '',
                active_off_checked: !responseItem.active ? 'checked="checked"' : ''
            };
        },
        useFormDataForSave: true // Important for file uploads
    });

    $('#brand_logo_file').on('change', function() {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                $('#brand_logo_preview_img').attr('src', e.target.result).show();
                $('#brand_logo_preview_container').show();
                $('#removeBrandLogoBtn').show();
            }
            reader.readAsDataURL(file);
            $('#current_logo').val(''); // Clear current_logo if new file is selected
        }
    });
    $('#removeBrandLogoBtn').on('click', function(){
        $('#brand_logo_file').val(''); // Clear file input
        $('#brand_logo_preview_img').attr('src', '#').hide();
        $('#brand_logo_preview_container').hide();
        $('#current_logo').val(''); // Mark for removal on server
        $(this).hide();
    });


    // --- Global Settings Save (if not handled by full page reload) ---
    // This is typically handled by PrestaShop's HelperOptions or a standard form submission
    // If you have a specific "Save Global Settings" button that should use AJAX:
    $('#module_form_submit_btn').on('click', function(e) {
        if ($(this).attr('name') === 'submitCustomThemeBuilderGlobal') { // Check if it's the global save
            // e.preventDefault(); // Uncomment if you want to handle via AJAX
            // var formData = $('#module_form').serialize(); // Or specific parts
            // $.post(ctb_ajax_url, formData + '&action=SaveGlobalSettings&ajax=1', function(response) { ... });
        }
    });


    // --- Image Uploader for Section Configs (Modal) ---
    $('body').on('click', '.btn-file-uploader', function() {
        var $button = $(this);
        var inputId = $button.data('input-id');
        var previewId = $button.data('preview-id');
        var uploadType = $button.data('upload-type'); // e.g. 'section_image', 'section_background'
        var sectionId = $button.data('section-id'); // Current section ID

        var $fileInput = $('<input type="file" accept="image/*" style="display:none;">');
        $('body').append($fileInput);

        $fileInput.on('change', function() {
            var file = this.files[0];
            if (file) {
                var formData = new FormData();
                formData.append('file', file);
                formData.append('ajax', true);
                formData.append('action', 'UploadImage'); // Generic AJAX action for image uploads
                formData.append('upload_type', uploadType);
                formData.append('id_item', sectionId); // Pass relevant ID

                // Show a loading indicator if you have one
                // $button.find('i').removeClass('icon-upload').addClass('icon-spinner icon-spin');

                $.ajax({
                    url: ctb_ajax_url,
                    type: 'POST',
                    data: formData,
                    contentType: false,
                    processData: false,
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            $('#' + inputId).val(response.filename);
                            if (previewId && $('#' + previewId).length) {
                                $('#' + previewId).attr('src', response.url + '?rand=' + Math.random()).show();
                                // Show remove button for the preview
                                 $('#' + previewId).next('.remove-image-btn').show();
                            }
                            showSuccessMessage(response.message || ctb_translations.imgUploadSuccess);
                        } else {
                            showErrorMessage(response.message || ctb_translations.imgUploadError);
                        }
                    },
                    error: function() {
                        showErrorMessage(ctb_translations.imgUploadError + ' (AJAX Error)');
                    },
                    complete: function() {
                        // $button.find('i').removeClass('icon-spinner icon-spin').addClass('icon-upload');
                        $fileInput.remove(); // Clean up temporary file input
                    }
                });
            } else {
                $fileInput.remove();
            }
        });
        $fileInput.click(); // Trigger file selection
    });

    // Remove image button for section config images
    $('body').on('click', '.remove-image-btn', function() {
        var inputId = $(this).data('input-id');
        var previewId = $(this).data('preview-id');
        $('#' + inputId).val('');
        if (previewId && $('#' + previewId).length) {
            $('#' + previewId).attr('src', '#').hide();
        }
        $(this).hide();
    });


    // Initialize tooltips (if Bootstrap tooltips are used)
    if (typeof $('[data-toggle="tooltip"]').tooltip === 'function') {
        $('[data-toggle="tooltip"]').tooltip();
    }

}); // End document.ready

// --- Helper Functions ---
function initializeSortable(listSelector, ajaxAction, idKey, successMsg, errorMsg) {
    $(listSelector).sortable({
        handle: '.drag-handle',
        placeholder: 'ui-sortable-placeholder',
        update: function(event, ui) {
            var order = $(this).sortable('toArray', { attribute: 'data-id' });
            var orderData = order.map(id => ({ id: id })); // Simplified for some cases, might need full {id: position} map

            $.post(ctb_ajax_url, {
                ajax: true,
                action: ajaxAction,
                order: orderData, // Send array of IDs in new order
                [idKey]: order // Some actions might expect the list of IDs directly
            }, function(response) {
                if (response.success) {
                    showSuccessMessage(response.message || successMsg);
                    // Update position numbers in DOM if displayed
                    $(listSelector).find('.section-item, .service-item, .brand-item-admin').each(function(index) {
                        $(this).find('.section-position, .service-position, .brand-position').text(index + 1);
                    });
                } else {
                    showErrorMessage(response.message || errorMsg);
                    $(listSelector).sortable('cancel'); // Revert if error
                }
            }, 'json').fail(function() {
                showErrorMessage(errorMsg + ' (AJAX Error)');
                $(listSelector).sortable('cancel');
            });
        }
    });
}

function addSectionItemToDOM(section) {
    var template = $('#newSectionTemplate').html();
    template = template.replace(/{id}/g, section.id_mltheme_section)
                       .replace(/{type}/g, section.type)
                       .replace(/{name}/g, section.display_name) // Use display_name for visible name
                       .replace(/{raw_name}/g, section.name)     // Use raw_name for internal name display
                       .replace(/{position}/g, section.position);
    $('#sections-list').append(template);
    // Re-initialize Bootstrap switches if they are not auto-initialized
    // if (typeof $.fn.bootstrapSwitch !== 'undefined') {
    //     $('#sections-list .section-item[data-id="'+section.id_mltheme_section+'"] .prestashop-switch').bootstrapSwitch();
    // }
}

function loadUploadedIcons() {
    var listDiv = $('#uploadedIconsList');
    listDiv.html('<p class="text-center"><i class="icon-spinner icon-spin"></i> ' + (ctb_translations.loading || 'Loading...') + '</p>');
    $.post(ctb_ajax_url, { ajax: true, action: 'GetUploadedIcons' }, function(response) {
        if (response.success && response.icons && response.icons.length > 0) {
            listDiv.empty();
            response.icons.forEach(function(icon) {
                listDiv.append(
                    '<div class="col-xs-4 col-sm-3 col-md-2">' +
                        '<div class="uploaded-icon-item" data-filename="' + icon.name + '">' +
                            '<img src="' + icon.url + '?rand='+Math.random()+'" alt="' + icon.name + '">' +
                            '<span>' + icon.name + '</span>' +
                        '</div>' +
                    '</div>'
                );
            });
        } else if (response.success) {
             listDiv.html('<p class="text-muted col-xs-12">' + (ctb_translations.noIconsUploaded || 'No icons uploaded yet.') + '</p>');
        } else {
            listDiv.html('<p class="alert alert-warning col-xs-12">' + (response.message || ctb_translations.errorLoadingIcons || 'Error loading icons.') + '</p>');
        }
    }, 'json').fail(function(){
        listDiv.html('<p class="alert alert-danger col-xs-12">' + (ctb_translations.errorLoadingIconsAjax || 'AJAX Error loading icons.') + '</p>');
    });
}


// Generic CRUD handler
function handleCRUDOperations(options) {
    const {
        listSelector, itemSelector, formSelector, submitButtonTextSelector, cancelButtonSelector, titleSelector,
        hiddenIdField, deleteButtonClass, editButtonClass, statusToggleClass, templateId,
        actions, idKey, nameKeyForTitle, nameKeyForTemplate,
        confirmDeleteMsg, itemAddedMsg, itemSavedMsg, itemDeletedMsg,
        addTitle, editTitlePrefix, addButtonText, saveButtonText,
        populateFormFunction, getTemplateDataFunction, useFormDataForSave = false
    } = options;

    // Add/Update
    $(formSelector).on('submit', function(e) {
        e.preventDefault();
        const isUpdate = parseInt($(hiddenIdField).val()) > 0;
        const action = isUpdate ? actions.update : actions.add;

        let saveData;
        let ajaxOptions = {
            url: ctb_ajax_url,
            type: 'POST',
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    showSuccessMessage(response.message || (isUpdate ? itemSavedMsg : itemAddedMsg));
                    if (!isUpdate && response[idKey.replace('id_','')]) { // Check if response has the item data
                         const templateData = getTemplateDataFunction(response[idKey.replace('id_','')]);
                         addGenericItemToDOM(templateId, listSelector, templateData);
                    } else if (isUpdate) {
                        // Update existing item in DOM if needed (e.g., name changed)
                        const itemInList = $(listSelector).find(itemSelector + '[data-id="' + $(hiddenIdField).val() + '"]');
                        if (itemInList.length && response[idKey.replace('id_','')]) {
                            const templateData = getTemplateDataFunction(response[idKey.replace('id_','')]);
                            // Simplistic update: replace name and icon/logo
                            itemInList.find('.section-name').text(templateData[nameKeyForTemplate]); // Assuming .section-name is used
                            if (templateData.icon_html) itemInList.find('.service-icon-preview').html(templateData.icon_html);
                            if (templateData.logo_html) itemInList.find('.brand-logo-preview').html(templateData.logo_html);
                        }
                    }
                    resetGenericForm(formSelector, titleSelector, addTitle, submitButtonTextSelector, addButtonText, cancelButtonSelector, hiddenIdField);
                } else {
                    showErrorMessage(response.message || ctb_translations.errorSavingConfig);
                }
            },
            error: function() {
                showErrorMessage(ctb_translations.errorSavingConfig + ' (AJAX Error)');
            }
        };

        if (useFormDataForSave) {
            saveData = new FormData(this);
            saveData.append('ajax', true);
            saveData.append('action', action);
            ajaxOptions.data = saveData;
            ajaxOptions.contentType = false;
            ajaxOptions.processData = false;
        } else {
            saveData = $(this).serialize() + '&ajax=true&action=' + action;
            ajaxOptions.data = saveData;
        }

        $.ajax(ajaxOptions);
    });

    // Edit
    $('body').on('click', editButtonClass, function() {
        const itemId = $(this).data('id');
        $.post(ctb_ajax_url, { ajax: true, action: actions.get, [idKey]: itemId }, function(response) {
            if (response.success && response[idKey.replace('id_','')]) {
                const itemData = response[idKey.replace('id_','')];
                populateFormFunction($(formSelector), itemData);
                $(titleSelector).text(editTitlePrefix + (itemData[nameKeyForTitle] || itemId));
                $(submitButtonTextSelector).text(saveButtonText);
                $(cancelButtonSelector).show();
                $(formSelector).find('input[type="file"]').val(''); // Clear file input on edit
            } else {
                showErrorMessage(response.message || 'Error fetching item data.');
            }
        }, 'json').fail(function() {
            showErrorMessage('Error fetching item data (AJAX Error).');
        });
    });

    // Delete
    $('body').on('click', deleteButtonClass, function() {
        if (!confirm(confirmDeleteMsg)) return;
        const itemElement = $(this).closest(itemSelector);
        const itemId = itemElement.data('id');
        $.post(ctb_ajax_url, { ajax: true, action: actions.delete, [idKey]: itemId }, function(response) {
            if (response.success) {
                itemElement.fadeOut(300, function() { $(this).remove(); });
                showSuccessMessage(response.message || itemDeletedMsg);
            } else {
                showErrorMessage(response.message || 'Error deleting item.');
            }
        }, 'json').fail(function() {
            showErrorMessage('Error deleting item (AJAX Error).');
        });
    });

    // Toggle Status
    $('body').on('change', statusToggleClass + ' input[type="radio"]', function() {
        const itemId = $(this).closest(itemSelector).data('id');
        const isActive = $(this).val() == '1';
        $.post(ctb_ajax_url, {
            ajax: true,
            action: actions.toggleStatus,
            [idKey]: itemId,
            active: isActive ? 1 : 0
        }, function(response) {
            if (response.success) {
                showSuccessMessage(response.message || ctb_translations.statusUpdated);
            } else {
                showErrorMessage(response.message || ctb_translations.errorUpdatingStatus);
                // Revert switch
                $(this).prop('checked', !isActive).siblings('input[type="radio"]').prop('checked', isActive);
            }
        }, 'json').fail(function() {
             showErrorMessage(ctb_translations.errorUpdatingStatus + ' (AJAX Error)');
             $(this).prop('checked', !isActive).siblings('input[type="radio"]').prop('checked', isActive);
        });
    });

    // Cancel Edit
    $(cancelButtonSelector).on('click', function() {
        resetGenericForm(formSelector, titleSelector, addTitle, submitButtonTextSelector, addButtonText, cancelButtonSelector, hiddenIdField);
         $(formSelector).find('input[type="file"]').val(''); // Clear file input
         // Clear previews for images if any
         $(formSelector).find('#brand_logo_preview_img, #service_icon_preview_img').hide().attr('src','#'); // Example
         $(formSelector).find('#current_logo, #current_icon').val('');
    });
}

function resetGenericForm(formSelector, titleSelector, addTitle, submitTextSelector, addBtnText, cancelBtnSelector, idFieldSelector) {
    $(formSelector)[0].reset();
    $(titleSelector).text(addTitle);
    $(submitTextSelector).text(addBtnText);
    $(cancelBtnSelector).hide();
    $(idFieldSelector).val('0');
    // Reset any specific previews or states
    if (formSelector === '#brandForm') {
        $('#brand_logo_preview_img').attr('src', '#').hide();
        $('#brand_logo_preview_container').hide();
        $('#removeBrandLogoBtn').hide();
        $('#current_logo').val('');
    }
    // Reset language fields to default if applicable (e.g., for services)
    if (typeof showServiceLangField === 'function') { showServiceLangField(default_language); }

}

function addGenericItemToDOM(templateId, listSelector, data) {
    var template = $(templateId).html();
    for (var key in data) {
        if (data.hasOwnProperty(key)) {
            var regex = new RegExp('{' + key + '}', 'g');
            template = template.replace(regex, data[key]);
        }
    }
    $(listSelector).append(template);
}


// PrestaShop specific growl-like notifications (if available, otherwise use alert)
function showSuccessMessage(message) {
    if (typeof showSuccessMessage === 'function' && $.fn.growl) { // Check if PS's showSuccessMessage is available
         $.growl.notice({ title: '', message: message }); // PS 1.7 growl
    } else if (typeof displayConfirmation === 'function') {
        displayConfirmation(message); // PS 1.6
    }
     else {
        alert('Success: ' + message);
    }
}

function showErrorMessage(message) {
     if (typeof showErrorMessage === 'function' && $.fn.growl) { // Check if PS's showErrorMessage is available
        $.growl.error({ title: '', message: message }); // PS 1.7 growl
    } else if (typeof displayError === 'function') {
        displayError(message); // PS 1.6
    }
     else {
        alert('Error: ' + message);
    }
}
