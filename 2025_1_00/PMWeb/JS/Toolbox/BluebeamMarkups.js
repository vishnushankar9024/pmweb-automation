function OnClientRated(sender, args) {
    var rating = $("input[id*='rdrating1']").val().split(":")[1].split(",")[0].replace('"', '').replace('"', '');
    //              $("span[id*='lblRating']").html("(" +rating +")");
    var wnd = window.radopen('RatingPopup.aspx?Rating=' + rating + '&Source=BLUEBEAMMARKUPS');
    wnd.setSize(424, 435);
    wnd.add_close(RefreshRating);
    wnd.Center();
    return false;
}
function RefreshRating(Opener) {
    var updatePanel = $find($("[id$=pnlRating]")[0].id);
    var btnRefreshRating = $("a[id*=rdgRating][id$=btnRefreshRating]")[0];;
    if (updatePanel && btnRefreshRating == null) { __doPostBack(updatePanel.get_id()); }
    else if (btnRefreshRating) {
        eval(btnRefreshRating.href.split(":")[1]);;
    }

}

