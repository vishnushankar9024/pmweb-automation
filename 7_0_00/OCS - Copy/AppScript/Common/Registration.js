var timeout;
var spanAvailability = $get("spanAvailability");

function CheckAvailability(username) {
    clearTimeout(timeout);
    if (username.length == 0)
        spanAvailability.innerHTML = "";
    else {
        spanAvailability.innerHTML = "<span style='color: #ccc;'>Checking...</span>";
        usernameCheckerTimer = setTimeout("IsAvailable('" + username + "');", 750);
    }
}

//Check Username availability
function IsAvailable(username) {
    // initiate the ajax pagemethod call
    // upon completion, the OnSucceded callback will be executed
    PageMethods.IsUserAvailable(username, OnSucceeded);
}

// Callback function invoked on successful completion of the page method.
function OnSucceeded(result, userContext, methodName) {
    if (methodName == "IsUserAvailable") {
        if (result == true)
            spanAvailability.innerHTML = "<span style='color: DarkGreen;'>Available</span>";
        else
            spanAvailability.innerHTML = "<span style='color: Red;'>Unavailable</span>";
    }
}