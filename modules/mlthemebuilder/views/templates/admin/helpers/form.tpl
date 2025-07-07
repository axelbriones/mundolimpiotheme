{* This is a generic helper form template. It might not be directly used if using PrestaShop's HelperForm class,
   as HelperForm generates its own markup. However, if building forms manually or for very custom parts of the admin,
   this structure could be a starting point. The modal forms for sections (hero.tpl, etc.) are more specific.

   For most admin forms, you'd use $helper->generateForm($fields_form).
   This file is more for demonstrating structure if you were to build a form manually with Smarty.
*}

{if isset($custom_form_fields) && $custom_form_fields}
    <form action="{$form_action|escape:'htmlall':'UTF-8'}" method="post" class="defaultForm form-horizontal" enctype="multipart/form-data">
        <div class="panel">
            <div class="panel-heading">
                <i class="icon-{$form_icon|default:'cog'|escape:'htmlall':'UTF-8'}"></i> {$form_title|default:'Form'|escape:'htmlall':'UTF-8'}
            </div>
            <div class="panel-body">
                {foreach from=$custom_form_fields item=field}
                    <div class="form-group">
                        <label class="control-label col-lg-3" for="{$field.name|escape:'htmlall':'UTF-8'}">
                            {$field.label|escape:'htmlall':'UTF-8'}
                            {if isset($field.required) && $field.required}<span class="text-danger">*</span>{/if}
                        </label>
                        <div class="col-lg-9">
                            {if $field.type == 'text' || $field.type == 'password' || $field.type == 'email' || $field.type == 'number' || $field.type == 'color'}
                                <input type="{$field.type|escape:'htmlall':'UTF-8'}"
                                       name="{$field.name|escape:'htmlall':'UTF-8'}"
                                       id="{$field.name|escape:'htmlall':'UTF-8'}"
                                       value="{$field.value|default:''|escape:'htmlall':'UTF-8'}"
                                       class="form-control {if isset($field.class)}{$field.class|escape:'htmlall':'UTF-8'}{/if}"
                                       {if isset($field.placeholder)}placeholder="{$field.placeholder|escape:'htmlall':'UTF-8'}"{/if}
                                       {if isset($field.required) && $field.required}required{/if}
                                       {if isset($field.min)}min="{$field.min|escape:'htmlall':'UTF-8'}"{/if}
                                       {if isset($field.max)}max="{$field.max|escape:'htmlall':'UTF-8'}"{/if}
                                       {if isset($field.step)}step="{$field.step|escape:'htmlall':'UTF-8'}"{/if}>
                            {elseif $field.type == 'textarea'}
                                <textarea name="{$field.name|escape:'htmlall':'UTF-8'}"
                                          id="{$field.name|escape:'htmlall':'UTF-8'}"
                                          class="form-control {if isset($field.class)}{$field.class|escape:'htmlall':'UTF-8'}{/if}"
                                          rows="{$field.rows|default:5|escape:'htmlall':'UTF-8'}"
                                          {if isset($field.placeholder)}placeholder="{$field.placeholder|escape:'htmlall':'UTF-8'}"{/if}
                                          {if isset($field.required) && $field.required}required{/if}
                                >{$field.value|default:''|escape:'htmlall':'UTF-8'}</textarea>
                            {elseif $field.type == 'select'}
                                <select name="{$field.name|escape:'htmlall':'UTF-8'}"
                                        id="{$field.name|escape:'htmlall':'UTF-8'}"
                                        class="form-control {if isset($field.class)}{$field.class|escape:'htmlall':'UTF-8'}{/if}"
                                        {if isset($field.required) && $field.required}required{/if}>
                                    {if isset($field.options) && is_array($field.options)}
                                        {foreach from=$field.options item=option}
                                            <option value="{$option.value|escape:'htmlall':'UTF-8'}" {if $option.value == $field.value|default:''}selected{/if}>
                                                {$option.label|escape:'htmlall':'UTF-8'}
                                            </option>
                                        {/foreach}
                                    {/if}
                                </select>
                            {elseif $field.type == 'switch'}
                                <span class="switch prestashop-switch fixed-width-lg">
                                    <input type="radio" name="{$field.name|escape:'htmlall':'UTF-8'}" id="{$field.name|escape:'htmlall':'UTF-8'}_on" value="1" {if $field.value|default:0 == 1}checked="checked"{/if}>
                                    <label for="{$field.name|escape:'htmlall':'UTF-8'}_on">{l s='Yes' d='Admin.Global'}</label>
                                    <input type="radio" name="{$field.name|escape:'htmlall':'UTF-8'}" id="{$field.name|escape:'htmlall':'UTF-8'}_off" value="0" {if $field.value|default:0 == 0}checked="checked"{/if}>
                                    <label for="{$field.name|escape:'htmlall':'UTF-8'}_off">{l s='No' d='Admin.Global'}</label>
                                    <a class="slide-button btn"></a>
                                </span>
                            {elseif $field.type == 'file'}
                                 <input type="file" name="{$field.name|escape:'htmlall':'UTF-8'}" id="{$field.name|escape:'htmlall':'UTF-8'}" class="form-control {if isset($field.class)}{$field.class|escape:'htmlall':'UTF-8'}{/if}" {if isset($field.accept)}accept="{$field.accept|escape:'htmlall':'UTF-8'}"{/if}>
                                 {if isset($field.current_value_url) && $field.current_value_url}
                                    <div style="margin-top:10px;">
                                        <img src="{$field.current_value_url|escape:'htmlall':'UTF-8'}?rand={rand(0,1000)}" alt="{l s='Current Image' d='Modules.Mlthemebuilder.Admin'}" style="max-height:60px; border:1px solid #ddd;">
                                        {if isset($field.current_value_filename) && $field.current_value_filename}
                                            <input type="hidden" name="current_{$field.name|escape:'htmlall':'UTF-8'}" value="{$field.current_value_filename|escape:'htmlall':'UTF-8'}">
                                        {/if}
                                    </div>
                                 {/if}
                            {elseif $field.type == 'hidden'}
                                <input type="hidden" name="{$field.name|escape:'htmlall':'UTF-8'}" value="{$field.value|default:''|escape:'htmlall':'UTF-8'}">
                            {else}
                                <!-- Other field types or custom HTML -->
                                {$field.html_content nofilter}
                            {/if}

                            {if isset($field.desc) && $field.desc}
                                <p class="help-block">{$field.desc|escape:'htmlall':'UTF-8'}</p>
                            {/if}
                        </div>
                    </div>
                {/foreach}
            </div>
            <div class="panel-footer">
                <button type="submit" name="{$form_submit_name|default:'submitForm'|escape:'htmlall':'UTF-8'}" class="btn btn-default pull-right">
                    <i class="process-icon-save"></i> {$form_submit_text|default:'Save'|escape:'htmlall':'UTF-8'}
                </button>
                {if isset($form_cancel_url) && $form_cancel_url}
                    <a href="{$form_cancel_url|escape:'htmlall':'UTF-8'}" class="btn btn-default">
                        <i class="process-icon-cancel"></i> {l s='Cancel' d='Admin.Actions'}
                    </a>
                {/if}
            </div>
        </div>
    </form>
{else}
    <div class="alert alert-warning">{l s='No form fields defined for this helper.' d='Modules.Mlthemebuilder.Admin'}</div>
{/if}
