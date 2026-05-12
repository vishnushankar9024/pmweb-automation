function ddlTasks_SelectedIndexChanged(sender, eventArgs) {
    var item = eventArgs.get_item();
    var itemId = item.get_parent()._clientStateFieldID;
    var tr = $("#" + itemId).parents(".rgEditForm:first");
    if (!tr || tr.length == 0)
        tr = $("#" + itemId).parents("tr:first")
    var txtStart = tr.find("input[id$='txtStartDate']");
    var txtFinish = tr.find("input[id$='txtFinishDate']");
    txtStart.val(item.get_attributes().getAttribute("EarlyStartDate"));
    txtFinish.val(item.get_attributes().getAttribute("EarlyFinishDate"));
}

