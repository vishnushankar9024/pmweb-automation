import { Ajax } from './Ajax.js';
var self = {}, pmwebext, _ajax, placeholder;
function DynamicButton(pmwebExt) {
    self = this;
    pmwebext = pmwebExt;
    _ajax = new Ajax();
    placeholder = $('#tdAction');
    if (placeholder.length > 0 && pmwebext.getUrlVar("Id") && pmwebext.getUser()) {
        //self.generate();
    }
    self.CreateEOI();
}
Object.assign(DynamicButton.prototype, {
    constructor: DynamicButton,
    generate: function () {
        _ajax.post(
            pmwebext.getHost() + '/DynamicButtons/Get', { Id: parseInt(pmwebext.getUrlVar("Id")), UserId: parseInt(pmwebext.getUser().Id) }).then((data) => self.generateButton(data));
    },
    generateButton: function (result) {
        var buttons = JSON.parse(result);
        var placeHolder = $('#tdAction');
        var fieldSet = jQuery('<fieldset/>', {
            css: {
                //height: '291px',
                height: 'auto',
                width: '188px'
            }
        });
        fieldSet.appendTo(placeHolder);
        jQuery('<legend/>').text("Generate").appendTo(fieldSet);
        placeHolder = jQuery('<div/>', {
            id: 'workflowDynamicButtons'
        }).appendTo(fieldSet);
        self.create(buttons);

    },
    create: function (buttons) {
        var placeholder = $('#workflowDynamicButtons');
        $.each(buttons, function (i) {
            var button = buttons[i];
            $('<br /><input type="button" value="' + button.Text + '" style="width:250px;" /><br />').click(function () { self.clickHandler(button) }).appendTo(placeholder);
        });
    },
    clickHandler: function (button) {
        self.createDialog();
        var winW = window.innerWidth;
        var winH = window.innerHeight;
        var dialogoverlay = document.getElementById('dialogoverlayDynamicButtons');
        var dialogbox = document.getElementById('dialogboxDynamicButtons');
        dialogoverlay.style.display = "block";
        dialogoverlay.style.height = winH + "px";

        var dialogLeft = (winW / 2) - (550 * .5);

        if (dialogLeft > 300) {
            dialogLeft = 300;
        }

        //dialogbox.style.left = dialogLeft + 'px';
        dialogbox.style.left = '40%';
        dialogbox.style.top = "140px";
        dialogbox.style.display = "block";

        document.getElementById('dialogboxheadDynamicButtons').innerHTML = "Confirmation";
        $("#dialogboxbodyDynamicButtons").html('');
        $("#dialogboxbodyDynamicButtons").append(button.ConfirmationText);
        $('<button />', {}).text('Yes')
            .click(function () {
                button.callback();
            }).appendTo($('#dialogboxfootDynamicButtons'));
        $('<button />', {}).text('No')
            .click(function () {
                self.destroyDialog();
            }).appendTo($('#dialogboxfootDynamicButtons'));
    },
    createDialog: function () {
        var dialogoverlay = jQuery('<div/>', {
            id: 'dialogoverlayDynamicButtons',
            css: {
                "display": "none",
                "position": "fixed",
                "top": "0px",
                "left": "0px",
                "background-color": "rgba(255, 255, 255, 0.8)",
                "width": "100%",
                "z-index": "10"
            }
        }).appendTo($('body'));
        var dialogbox = jQuery('<div/>', {
            id: 'dialogboxDynamicButtons',
            css: {
                "display": "none",
                "position": "fixed",
                "background": "#000",
                "border-radius": "7px",
                "width": "550px",
                "z-index": "10"
            }
        }).appendTo(dialogoverlay);
        var div = jQuery('<div />', {
            css: {
                "background": "#FFF",
                "margin": "8px"
            }
        }).appendTo(dialogbox);
        jQuery('<div/>', {
            id: 'dialogboxheadDynamicButtons',
            css: {
                "background": "#666",
                "font-size": "19px",
                "padding": "10px",
                "color": "#ccc"

            }
        }).appendTo(div);
        jQuery('<div/>', {
            id: 'dialogboxbodyDynamicButtons',
            css: {
                "background": "#333",
                "padding": "20px",
                "color": "#FFF"

            }
        }).appendTo(div);
        jQuery('<div/>', {
            id: 'dialogboxfootDynamicButtons',
            css: {
                "background": "#666",
                "padding": "10px",
                "text-align": "right"

            }
        }).appendTo(div);
    },
    destroyDialog: function () {
        $('#dialogoverlayDynamicButtons').remove();
    },
    createPreview: function () {
        //<a id="PreviewButton" style="padding: 2px 17px; border: 2px outset buttonface; border-image: none; text-align: center; color: buttontext; white-space: pre; cursor: pointer; box-sizing: border-box; align-items: flex-start; background-color: buttonface; -webkit-appearance: push-button; user-select: none;" onclick="this.href='https://pmweb.hamad.qa/pmwebhelper/hmc/PMWebWordToPDF?RecordId='+document.getElementById('ctl00_CPH1_ddlCustomForms_Input').value.replace(/#/gi, '')
        //                + '&amp;ObjectType=CUSTOMFORMTYPE_ONLINE%20MEMO&amp;CustomFormTypeId=177&amp;TemplateId=7&amp;RecordTypeId=10171' " target="iframe_a">Preview</a>
        $('<a />', {
            css: {
                'padding': '2px 17px',
                'border': '2px outset buttonface',
                'border-image': 'none',
                'text-align': 'center',
                'color': 'center',
            }
        });
    },
    CreateEOI: function () {
        if (pmwebext.getPage().toLowerCase() === 'customforms.aspx' && pmwebext.getUrlVar('TypeId') === '10006' && $('#btnCreateEOI').length > 0) {
            $('<button />', {}).text('Ceate EOI')
                .click(function (e) {
                    e.preventDefault();
                    _ajax.post(pmwebext.getHost() + '/PreBid/GetTesPreBidLinkedRecords', { Id: parseInt(pmwebext.getUrlVar("Id")) }).then((data) => {
                        var html = '';
                        var jsonData = JSON.parse(data);
                        if (jsonData.length > 0) {
                            html += 'EOI Created:';
                        }
                        $.each(jsonData, function (i) {
                            html += '<br /><a href="' + jsonData[i].RecordLink + '" style="color:#FFFFFF;">' + jsonData[i].Description + '</a>';
                        });
                        if (jsonData.length > 0) {
                            html += '<br /><br />';
                        }
                        html += 'Are you sure to create EOI?';
                        //html += self.GetWindowButton(function () { alert('test')});
                        //pmwebext.InitWindow('Ceate EOI', html);
                        self.clickHandler({
                            ConfirmationText: html, callback: function () {
                                _ajax.post(
                                    pmwebext.getHost() + '/DynamicButtons/CreateEOI', { Id: parseInt(pmwebext.getUrlVar("Id")), UserId: parseInt(pmwebext.getUser().Id) }
                                ).then((data) => {
                                    location.href = pmwebext.getHost(true) + '/PreBid.aspx?Id=' + data + '&ModuleId=1&PageId=286';
                                });
                            }
                        });
                    });
                }).appendTo($('#btnCreateEOI'));
        }
    },
    GetWindowButton: function (callback) {
        var div = jQuery('<div />', {
            css: { "text-align": "right" }
        });
        $('<button />', {}).text('Yes')
            .click(function () {
                callback();
            }).appendTo(div);
        $('<button />', {}).text('No')
            .click(function () {
                self.destroyDialog();
            }).appendTo(div);
        return div.html();
    }
});
export { DynamicButton };