{* This is a generic helper list template. Similar to form.tpl, it's more for manual list building
   if not using PrestaShop's HelperList class. HelperList generates its own complex markup.
   This demonstrates a basic list structure with Smarty.
*}

{if isset($list_title) && $list_title}
    <div class="panel">
        <div class="panel-heading">
            <i class="icon-{$list_icon|default:'list'|escape:'htmlall':'UTF-8'}"></i> {$list_title|escape:'htmlall':'UTF-8'}
            {if isset($add_new_url) && $add_new_url}
                <span class="btn-group-action">
                    <a href="{$add_new_url|escape:'htmlall':'UTF-8'}" class="btn btn-default">
                        <i class="icon-plus"></i> {l s='Add new' d='Admin.Actions'}
                    </a>
                </span>
            {/if}
        </div>
{/if}

{if isset($list_items) && $list_items|count > 0}
    <table class="table table-bordered table-striped {if isset($list_sortable) && $list_sortable}sortable{/if}">
        <thead>
            <tr>
                {if isset($list_sortable) && $list_sortable}<th></th>{/if}
                {foreach from=$list_headers item=header}
                    <th>{$header.label|escape:'htmlall':'UTF-8'}</th>
                {/foreach}
                {if isset($list_actions) && $list_actions|count > 0}
                    <th class="text-right">{l s='Actions' d='Admin.Global'}</th>
                {/if}
            </tr>
        </thead>
        <tbody {if isset($list_sortable) && $list_sortable}class="sortable-items" data-sort-url="{$sort_url|escape:'htmlall':'UTF-8'}"{/if}>
            {foreach from=$list_items item=item}
                <tr data-id="{$item.id|escape:'htmlall':'UTF-8'}">
                    {if isset($list_sortable) && $list_sortable}
                        <td class="dragHandle"><i class="icon-move"></i></td>
                    {/if}
                    {foreach from=$list_headers item=header}
                        <td>
                            {if $header.type == 'bool_status' && isset($item[$header.key])}
                                <span class="label label-{if $item[$header.key]}success{else}danger{/if}">
                                    {if $item[$header.key]}{l s='Yes' d='Admin.Global'}{else}{l s='No' d='Admin.Global'}{/if}
                                </span>
                            {elseif $header.type == 'image' && isset($item[$header.key])}
                                <img src="{$item[$header.key]|escape:'htmlall':'UTF-8'}" alt="" style="max-height: 40px;">
                            {else if isset($item[$header.key])}
                                {$item[$header.key]|escape:'htmlall':'UTF-8'}
                            {else}
                                --
                            {/if}
                        </td>
                    {/foreach}
                    {if isset($list_actions) && $list_actions|count > 0}
                        <td class="text-right">
                            <div class="btn-group-action">
                                <div class="btn-group">
                                    {foreach from=$list_actions item=action}
                                        {if $action.type == 'edit'}
                                            <a href="{$action.url|replace:'ID_ITEM':$item.id|escape:'htmlall':'UTF-8'}" class="btn btn-default">
                                                <i class="icon-pencil"></i> {l s='Edit' d='Admin.Actions'}
                                            </a>
                                        {elseif $action.type == 'delete'}
                                            <a href="{$action.url|replace:'ID_ITEM':$item.id|escape:'htmlall':'UTF-8'}" class="btn btn-default list-action-delete" onclick="return confirm('{l s='Are you sure you want to delete this item?' d='Admin.Notifications.Warning'}');">
                                                <i class="icon-trash"></i> {l s='Delete' d='Admin.Actions'}
                                            </a>
                                        {elseif $action.type == 'custom'}
                                            <a href="{$action.url|replace:'ID_ITEM':$item.id|escape:'htmlall':'UTF-8'}" class="btn btn-default {$action.class|default:''|escape:'htmlall':'UTF-8'}" title="{$action.label|escape:'htmlall':'UTF-8'}">
                                                <i class="icon-{$action.icon|default:'cog'|escape:'htmlall':'UTF-8'}"></i>
                                                {if isset($action.label_visible) && $action.label_visible} {$action.label|escape:'htmlall':'UTF-8'}{/if}
                                            </a>
                                        {/if}
                                    {/foreach}
                                </div>
                            </div>
                        </td>
                    {/if}
                </tr>
            {/foreach}
        </tbody>
    </table>
{else}
    <div class="alert alert-warning">{l s='No items found.' d='Modules.Mlthemebuilder.Admin'}</div>
{/if}

{if isset($list_title) && $list_title}
    </div>
{/if}

{if isset($list_sortable) && $list_sortable}
<script type="text/javascript">
    $(function() {
        $(".sortable-items").sortable({
            handle: ".dragHandle",
            placeholder: "ui-state-highlight",
            axis: "y",
            update: function(event, ui) {
                var sortedIDs = $(this).sortable("toArray", { attribute: "data-id" });
                var sortUrl = $(this).data('sort-url');
                $.ajax({
                    type: "POST",
                    url: sortUrl, // This URL needs to handle the reordering
                    data: {
                        ajax: true,
                        action: 'updatePositions', // Or your specific action
                        order: sortedIDs
                    },
                    success: function(response) {
                        // Handle success (e.g., show a notification)
                        if(response.success) {
                            showSuccessMessage(response.message || 'Order updated successfully.');
                        } else {
                            showErrorMessage(response.message || 'Error updating order.');
                            $(".sortable-items").sortable('cancel'); // Revert on error
                        }
                    },
                    error: function() {
                        showErrorMessage('AJAX error updating order.');
                        $(".sortable-items").sortable('cancel');
                    }
                });
            }
        }).disableSelection();
    });
</script>
<style>
    .dragHandle { cursor: move; }
    .ui-state-highlight { height: 1.5em; line-height: 1.2em; background: #f0f0f0; border: 1px dashed #ccc; }
</style>
{/if}
