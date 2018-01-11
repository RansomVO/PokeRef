var TitleResources = 'Pokemon Resources'
var CollapserWebSitesId = 'WEB_SITES';
var CollapserAndroidToolsId = 'ANDROID_TOOLS';
var CollapserGoIVId = 'GOIV_TOOL';
var CollapserIVToolkitId = 'IV_TOOLKIT';

var TitleSeatleResources = 'Seattle Area Resources';
var CollapserDiscordId = 'DISCORD';
var CollapserMapsId = 'MAPS';
var CollapserSocialId = 'SOCIAL';

var TitleTips = 'Pokemon Tips';
var CollapserAdvancedSearchId = 'ADVANCED_SEARCH';
var CollapserEeveelutionsId = 'EEVEELUTIONS';



function LocalScript() {
    try {
        if (document.title === TitleResources) {
            SetCollapser(CollapserWebSitesId);
            SetCollapser(CollapserAndroidToolsId);
            SetCollapser(CollapserGoIVId);
            SetCollapser(CollapserIVToolkitId);
        } else if (document.title === TitleSeatleResources) {
            SetCollapser(CollapserDiscordId);
            SetCollapser(CollapserMapsId);
            SetCollapser(CollapserSocialId);
        } else if (document.title === TitleTips) {
            SetCollapser(CollapserAdvancedSearchId);
            SetCollapser(CollapserEeveelutionsId);
        }
    } catch (err) {
        ShowError(err);
    }
}
