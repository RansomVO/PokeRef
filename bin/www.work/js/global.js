// ==============================================================================================
// #region window.onload()  Called when page is loaded to perform up-front work.
// ==============================================================================================
// If there was already an window.onload specified, hold on to it and call it before we do our work.
var globalOldOnLoad = window.onload;
window.onload = function () {
    try {
        if (globalOldOnLoad != null) {
            globalOldOnLoad();
        }

        if (typeof ProcessParameter === "function") {
            // TODO QZX: Take into account quote marks to allow "&" to be part of the value.
            var parameters = window.location.search.substring(1).split('&');
            for (var i = parameters.length - 1; i >= 0; i--) {
                if (parameters[i] !== null && parameters[i] !== '') {
                    var parameter = parameters[i].split('=');
                    if (parameter[1] !== undefined && parameter[1] !== null) {
                        parameter[1] = parameter[1].Trim(true, '"', '%22');
                    }
                    ProcessParameter(parameter[0], parameter[1]);
                }
            }
        }
    } catch (err) {
        ShowError(err);
    }
}

// #endregion

// ==============================================================================================
// #region Global Variables
// ==============================================================================================

// ==============================================================================================
// Variables to help make it so cached files will be updated appropriately.
// ==============================================================================================
var CacheDate = '?cacherefresh=2018-03-06_11:50:47'; // This line will be updated with the build
var NeverCache = '?nevercache=' + Math.random();    // (Currently unused.)

// #endregion

// ==============================================================================================
// #region Add functionality that is missing from some browsers (usually IE)
// ==============================================================================================

if (!String.prototype.startsWith) {
    String.prototype.startsWith = function (searchString, position) {
        position = position || 0;
        return this.indexOf(searchString, position) === position;
    };
}

function RegisterTristateCheckbox(checkbox) {
    // IE does not fire a change event when it is clicked while in the indeterminate state, so we manually add a trigger.
    if (IsIE()) {
        PokeType_All_Check.addEventListener('mousedown', function () {
            if (this.indeterminate) {
                var event = document.createEvent("MouseEvents");
                event.initEvent("change", true, true);
                event.eventName = "change";
                this.indeterminate = false;
                this.dispatchEvent(event);
            }
        });
    }
}

// #endregion

// ==============================================================================================
// #region Add functionality to String class.
// ==============================================================================================

if (!String.prototype.endsWith) {
    String.prototype.endsWith = function (searchString) {
        return substring(length - searchString.length) === searchString;
    };
}

if (!String.prototype.contains) {
    String.prototype.contains = function (searchString) {
        return this.indexOf(searchString) !== -1;
    };
}

// Method to trim specified strings from the beginning and end of the string.
if (!String.prototype.Trim) {
    // NOTE: Don't be fooled because there is only one parameter specified. You still pass in the strings you want trimmed.
    //  E.G. myString.Trim(yes, '-', '&nbsp;', '"');
    String.prototype.Trim = function (trimWhiteSpace) {
        var trimWhiteSpace = false;
        var result = this;

        // If first param is boolean then it says whether to trim white-space or not.
        var start = 0;
        if (typeof arguments[0] === 'boolean') {
            result = result.trim();
            start++;
        }

        var done = false;
        while (!done) {
            done = true;
            for (var i = arguments.length - 1; i >= start; i--) {
                if (result.startsWith(arguments[i])) {
                    result = result.substring(arguments[i].length);
                    done = false;
                }
                if (result.endsWith(arguments[i])) {
                    result = result.substring(0, result.length - arguments[i].length);
                    done = false;
                }
            }
        }

        return result;
    };


    /*
        // TODO QZX: "..." is not supported in IE 11. When we decide IE 11 is no longer supported, replace existing code with this.
        String.prototype.Trim = function (trimWhiteSpace, ...toTrim) {
        var result = this;
        if (trimWhiteSpace) {
            result = result.trim();
        }

        var done = false;
        while (!done) {
            done = true;
            for (var i = toTrim.length - 1; i >= 0; i--) {
                if (result.startsWith(toTrim[i])) {
                    result = result.substring(toTrim[i].length);
                    done = false;
                }
                if (result.endsWith(toTrim[i])) {
                    result = result.substring(0, result.length - toTrim[i].length);
                    done = false;
                }
            }
        }

        return result;
    };
    */
}

// #endregion

// ==============================================================================================
// #region Various Helper functions.
// ==============================================================================================

// Function to determine whether the client is a mobile device or not.
function IsMobile() {
    return /(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|ipad|iris|kindle|Android|Silk|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(navigator.userAgent)
        || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(navigator.userAgent.substr(0, 4));
}

// Function to determine whether we are running on IE, because in some cases IE works differently than the other browers.
function IsIE() {
    return window.navigator.userAgent.contains('Trident');
}

// #endregion

// ==============================================================================================
// #region Functions for easily getting and setting the values for a field.
// ==============================================================================================

function GetFieldValue(field) {
    // Special Cases.
    if (field.nodeName.toUpperCase() === 'INPUT' && field.type.toUpperCase() === 'CHECKBOX') {
        return Boolean(field.checked);
    }

    // Default Case
    return field.value;
}

function GetFieldValueById(fieldId) {
    return GetFieldValue(document.getElementById(fieldId));
}

function SetFieldValue(field, value) {
    switch (field.type) {
        case 'checkbox':
            field.checked = (value === 'true');
            break;

        default:
            field.value = value;
    }
}

function SetFieldValueById(fieldId, value) {
    SetFieldValue(document.getElementById(fieldId), value);
}

// #endregion

// ==============================================================================================
// #region Code to work with Cookies
// ==============================================================================================

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

            SetFieldValue(field, value);
        }
    } catch (err) {
        ShowError(err);
    }
}

// Takes an Associative Array of settings (Id: defaultValue) and applies them to the appropiate fields.
function ApplyCookieSettings(cookieSettings) {
    try {
        Object.keys(cookieSettings).forEach(function (key) {
            ApplyCookieSetting(key, cookieSettings[key]);
        });
    } catch (err) {
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

        // Default Case
        var value = GetFieldValue(field);
        if (defaultValue !== null && defaultValue === value)
            RemoveCookieSetting(fieldId);
        else
            SetCookieSetting(fieldId, value);
    } catch (err) {
        ShowError(err);
    }
}

// Takes an Associative Array of settings (Id: defaultValue) and Updates them in the Cookie.
function UpdateCookieSettings(cookieSettings) {
    try {
        Object.keys(cookieSettings).forEach(function (key) {
            UpdateCookieSetting(key, cookieSettings[key]);
        });
    } catch (err) {
        ShowError(err);
    }
}

// Takes an Associative Array of settings (Id: defaultValue) and Updates them in the Cookie.
function ClearCookieSettings(cookieSettings) {
    try {
        Object.keys(cookieSettings).forEach(function (key) {
            RemoveCookieSetting(key);
        });
    } catch (err) {
        ShowError(err);
    }
}

// Clear the entire cookie for the entire web site.
function ClearCookie() {
    try {
        localStorage.clear()
    } catch (err) {
        ShowError(err);
    }
}

function GetCookieSetting(id) {
    try {
        return localStorage.getItem(id);
    } catch (err) {
        ShowError(err);
    }
}

function SetCookieSetting(id, value) {
    try {
        localStorage.setItem(id, value);
    } catch (err) {
        ShowError(err);
    }
}

// Removes a single cookie setting with the specified id from the Cookie.
function RemoveCookieSetting(id) {
    try {
        localStorage.removeItem(id);
    } catch (err) {
        ShowError(err);
    }
}

// #endregion

// ==============================================================================================
// #region Basic methods access a file from a specified URL.
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

function InsertLinksList(url) {
    document.write(GetLinksList(url));
}

function GetLinksList(url, style) {
    var results = '<ul';
    if (style !== undefined && style !== '') {
        results += ' style="' + style + '"';
    }
    results += '>' + ReadURL(url) + '</ul>';

    return results;
}

// #endregion

// ==============================================================================================
// #region A bunch of methods that can be used to insert specific content.
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
        document.write(GetFooterNavigation('/'));
        document.write('<br /><hr align="left" width="650em" />');
    }

    document.write(ReadURL('/footernote.html' + CacheDate));
    WriteFeedbackNote();
    document.write('<br /><br /><br />');
}

function GetFooterNavigation(href) {
    if (location.pathname === '/') {
        // We are on the home page, so do nothing.
        return '';
    }

    var navigation = '';
    if (href === '/') {
        navigation = '<h2>Navigation</h2>'
            + '<div style="font-size:1.75em;">';
    } else if (href === location.pathname || location.pathname.substring(href.length, location.pathname.length) === 'index.html') {
        // We don't need a link for this, so just do the sublinks.
        return GetLinksList(href + '_linkslist.html' + CacheDate, 'font-size:smaller;')
    }

    var sectionName = ReadURL(href + '_sectionname.txt' + CacheDate);
    if (sectionName !== '') {
        navigation = navigation +
            '<ul style="font-size:smaller;">\r\n' +
            '  <li>\r\n' +
            '    <a ' + 'href="' + href + '">Back to ' + sectionName + '</a>\r\n';

        var subhref = location.pathname.substring(0, location.pathname.indexOf('/', href.length) + 1);
        if (subhref.length !== 0) {
            navigation = navigation + GetFooterNavigation(subhref);
        } else {
            // We are at the bottom. Add sibling links here.
            navigation = navigation + GetLinksList(subhref + '_linkslist.html' + CacheDate, 'font-size:smaller;');
        }

        navigation = navigation +
            '  </li>\r\n' +
            '</ul>\r\n';
    }

    if (href === '/') {
        navigation = navigation + '</div>';
    }

    return navigation;
}

// #endregion

// ==============================================================================================
// Called to display a message when there is an Exception.
// ==============================================================================================
function ShowError(err) {
    alert('ERROR!!!\n'
        + 'It would be very, very appreciated if you would send a screenshot of this dialog to Jay Arvitu at pokeeref@gmail.com'
        + '\n'
        + '\n' + err.message
        + '\n'
        + '\n----------------------'
        + '\n' + err.stack);
    + '\n'
}
