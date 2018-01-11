// ==============================================================================================
// Variables to help make it so cached files will be updated appropriately.
// ==============================================================================================
var CacheDate = '?cacherefresh={$CurrentDate}'; // This line will be updated with the build
var NeverCache = '?nevercache=' + Math.random();    // (Currently unused.)

// ==============================================================================================
// Called when page is loaded to perform up-front work.
// ==============================================================================================
window.onload = function () {
    // This allows individual page to define scripts that are local to them.
    //  Any non-value modifications should be done here.
    //  (E.G. Collapsers, javascript initial values/calculations, etc.)
    try {
        if (typeof LocalScript === "function") {
            LocalScript();
        }
    }
    catch (err) {
        ShowError(err);
    }
}


// ==============================================================================================
// Various Helper functions.
// ==============================================================================================

function IsMobile() {
    return /(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|ipad|iris|kindle|Android|Silk|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(navigator.userAgent)
        || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(navigator.userAgent.substr(0, 4));
}


// ==============================================================================================
// Code to work with Cookies
// ==============================================================================================

// -----------------------------------------------------------------------------------------------------------------------------------
// TODO QZX: All javascript that calls this function needs to be updated to use the new function then the function should be removed.
function ApplyCookieSettingsQZX(settings) {
    try {
        for (var i = 0, len = settings.length; i < len; i++) {
            if (Array.isArray(settings[i])) {
                ApplyCookieSetting(settings[i][0], settings[i][1]);
            } else if (settings[i] != null) {
                ApplyCookieSetting(settings[i]);
            }
        }
    }
    catch (err) {
        ShowError(err);
    }
}

// TODO QZX: All javascript that calls this function needs to be updated to use the new function then the function should be removed.
function UpdateCookieSettingsQZX(fieldIds) {
    try {
        for (var i = 0, len = settings.length; i < len; i++) {
            if (Array.isArray(settings[i])) {
                UpdateCookieSetting(settings[i][0], settings[i][1]);
            } else if (settings[i] != null) {
                UpdateCookieSetting(settings[i]);
            }
        }
    }
    catch (err) {
        ShowError(err);
    }
}

// TODO QZX: All javascript that calls this function needs to be updated to use the new function then the function should be removed.
function ClearCookieSettingsQZX(settings) {
    try {
        for (var i = 0, len = settings.length; i < len; i++) {
            if (Array.isArray(settings[i])) {
                localStorage.removeItem(settings[i][0]);
            } else if (settings[i] != null) {
                localStorage.removeItem(settings[i]);
            }
        }
    }
    catch (err) {
        ShowError(err);
    }
}

// -----------------------------------------------------------------------------------------------------------------------------------


// Applies a single cookie setting to the field with the specified fieldId.
//  (If there is no cookie setting, the set the field to the defaultValue.)
function ApplyCookieSetting(fieldId, defaultValue) {
    try {
        var value = GetCookieSetting(fieldId);
        if (value === null) {
            value = defaultValue;
        }

        if (value !== null) {
            var field = document.getElementById(fieldId);

            switch (field.type) {
                case 'checkbox':
                    field.checked = (value === 'true');
                    break;

                default:
                    field.value = value;
            }
        }
    }
    catch (err) {
        ShowError(err);
    }
}

// Takes an Associative Array of settings (Id: defaultValue) and applies them to the appropiate fields.
function ApplyCookieSettings(cookieSettings) {
    try {
        Object.keys(cookieSettings).forEach(function (key) {
            ApplyCookieSetting(key, cookieSettings[key]);
        });
    }
    catch (err) {
        ShowError(err);
    }
}

// Updates a single cookie setting from the field with the specified fieldId.
//  (If the field has the default value, just remove the setting from the cookie.)
function UpdateCookieSetting(fieldId, defaultValue) {
    try {
        var field = document.getElementById(fieldId);

        // Field with specified ID is not found, so skip it.
        if (field === null) {
            alert('Field "' + fieldId + '" not found.');
            return;
        }

        // Special Cases.
        if (field.nodeName.toUpperCase() === 'INPUT' && field.type.toUpperCase() === 'CHECKBOX') {
            var checked = Boolean(field.checked);
            if (defaultValue !== null && defaultValue === checked)
                RemoveCookieSetting(fieldId);
            else
                SetCookieSetting(fieldId, checked);

            return;
        }

        // Default Case
        var text = field.value;
        if (defaultValue !== null && defaultValue === text)
            RemoveCookieSetting(fieldId);
        else
            SetCookieSetting(fieldId, text);
    }
    catch (err) {
        ShowError(err);
    }
}

// Takes an Associative Array of settings (Id: defaultValue) and Updates them in the Cookie.
function UpdateCookieSettings(cookieSettings) {
    try {
        Object.keys(cookieSettings).forEach(function (key) {
            UpdateCookieSetting(key, cookieSettings[key]);
        });
    }
    catch (err) {
        ShowError(err);
    }
}

// Takes an Associative Array of settings (Id: defaultValue) and Updates them in the Cookie.
function ClearCookieSettings(cookieSettings) {
    try {
        Object.keys(cookieSettings).forEach(function (key) {
            RemoveCookieSetting(key);
        });
    }
    catch (err) {
        ShowError(err);
    }
}

// Clear the entire cookie.
function ClearCookie() {
    try {
        localStorage.clear()
    }
    catch (err) {
        ShowError(err);
    }
}

function GetCookieSetting(id) {
    return localStorage.getItem(id);
}

function SetCookieSetting(id, value) {
    localStorage.setItem(id, value);
}

// Removes a single cookie setting with the specified id from the Cookie.
function RemoveCookieSetting(id) {
    localStorage.removeItem(id);
}


// ==============================================================================================
// Basic methods access a file from a specified URL.
// ==============================================================================================

function ReadURL(url) {
    var request = new XMLHttpRequest();
    request.open('GET', url, false);
    request.send(null);
    if (request.status === 200) {
        return request.responseText;
    }

    return '';
}

function InsertURL(url) {
    document.write(ReadURL(url));
}


// ==============================================================================================
// A bunch of methods that can be used to insert specific content.
//  (So we can update it in one place.)
// ==============================================================================================

function WriteContactInfo() {
    document.write(ReadURL('/contactinfo.html' + CacheDate));
}

function WriteFeedbackNote() {
    document.write(ReadURL('/feedbacknote.html' + CacheDate));
    WriteContactInfo();
}

// Writes the bottom line separator, then if not the home page it starts the link section with a link to the home page.
function WriteFooter() {
    document.write('<br /><br /><hr class="BOTTOM_BORDER" />');

    if (location.pathname === '/') {
        document.write('<br />');
    } else {
        document.write(GetNavigation('/'));
        document.write('<br /><hr align="left" width="650em" />');
    }

    document.write(ReadURL('/footernote.html' + CacheDate));
    WriteFeedbackNote();
    document.write('<br /><br /><br />');
}

function GetNavigation(href) {
    if (location.pathname === '/') {
        // We are on the home page, so do nothing.
        return '';
    }

    var navigation = '';
    if (href === '/') {
        navigation = '<h2>Navigation</h2>';
    } else if (href === location.pathname || location.pathname.substring(href.length, location.pathname.length) === 'index.html') {
        // We don't need a link for this, so just do the sublinks.
        return navigation = navigation + ReadURL(href + '_linkslist.html' + CacheDate);
    }

    var sectionName = ReadURL(href + '_sectionname.txt' + CacheDate);
    if (sectionName !== '') {
        navigation = navigation +
            '<ul>\r\n' +
            '  <li>\r\n' +
            '    <a ' + GetLinkStyle(href) + 'href="' + href + '">Back to ' + ReadURL(href + '_sectionname.txt' + CacheDate) + '</a>\r\n';

        var subhref = location.pathname.substring(0, location.pathname.indexOf('/', href.length) + 1);
        if (subhref.length !== 0) {
            navigation = navigation + GetNavigation(subhref);
        } else {
            // We are at the bottom. Add sibling links here.
            navigation = navigation + ReadURL(subhref + '_linkslist.html' + CacheDate);
        }

        navigation = navigation +
            '  </li>\r\n' +
            '</ul>\r\n';
    }

    return navigation;
}

function GetLinkStyle(href) {
    if (href === '/')
        return 'class="LINK_HOME_PAGE"';

    if (href[href.length - 1] === '/')
        return 'class="LINK_SECTION_PAGE"';

    if (href === '.')
        return 'class="LINK_PARENT_PAGE"';

    return 'class="LINK_SIBLING_PAGE"';
}


// ==============================================================================================
//  Methods for hooking up a Collapser for a field.
// ==============================================================================================

var CollapserMarker = '_COLLAPSER';
var StatusUp = 'UP';
var StatusDown = 'DOWN';

function SetCollapser(CollapserId) {
    var collapser = document.getElementById(CollapserId + CollapserMarker);
    collapser.formTarget = CollapserId;
    var collapsee = document.getElementById(CollapserId);

    collapser.setAttribute('onclick', 'ToggleCollapser(event)');

    var state = GetCookieSetting(CollapserId + '_COLLAPSE', collapser.value);
    SetCollapseState(state !== null ? state : StatusDown, collapser, collapsee);
}

function ToggleCollapser(event) {
    var collapser = event.currentTarget;
    var collapseeFieldId = collapser.formTarget;
    var collapsee = document.getElementById(collapseeFieldId);

    // Find what new state should be.
    var state = collapser.value === StatusDown ? StatusUp : StatusDown;
    SetCollapseState(state, collapser, collapsee);

    SetCookieSetting(collapser.formTarget + '_COLLAPSE', state);
}

function SetCollapseState(state, collapser, collapsee) {
    if (state === StatusUp) {
        // Hide collapsee
        collapsee.style.display = 'none';

        // Update state.
        collapser.innerHTML = '&bigtriangleup;'
        collapser.value = StatusUp;
    } else {
        // Show collapsee
        collapsee.style.display = 'block';

        // Update state.
        collapser.innerHTML = '&bigtriangledown;'
        collapser.value = StatusDown;
    }
}


// ==============================================================================================
// Called to display a message when there is an Exception.
// ==============================================================================================
function ShowError(err) {
    alert('ERROR!'
        + 'It would very, very appreciated if you would send a screenshot of this dialog to Jay Arvitu at pokeeref@gmail.com'
        + '\n'
        + '\n' + err.message
        + '\n'
        + '\n----------------------'
        + '\n' + err.stack);
    + '\n'
}
