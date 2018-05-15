// #region Common

// ============================================================================
// ===== Cookies
// ============================================================================
// #region Cookies

// ================================================================================================
// Fields that should be saved in cookies, with their default values.
var CookieSettings = {
    'FieldResearch_Slider_OrderBy': 'false',
    'Reward_Encounter': 'true',
    'Reward_Razz': 'true',
    'Reward_Nanab': 'true',
    'Reward_Pinap': 'true',
    'Reward_Potion': 'true',
    'Reward_SuperPotion': 'true',
    'Reward_HyperPotion': 'true',
    'Reward_MaxPotion': 'true',
    'Reward_Revive': 'true',
    'Reward_MaxRevive': 'true',
    'Reward_PokeBall': 'true',
    'Reward_GreatBall': 'true',
    'Reward_UltraBall': 'true',
    'Reward_Stardust': 'true',
    'Reward_RareCandy': 'true',
    'Reward_FastTM': 'true',
    'Reward_ChargedTM': 'true',
    'Reward_XP': 'true',
};

// Read the Cookie and apply it to the fields.
function ApplyCookie() {
    ApplyCookieSettings(CookieSettings);
    ToggleChart();
}

// #endregion Cookies

// ==============================================================================================
// Called when page is loaded to perform up-front work.
// ==============================================================================================
// NOTE: This .js MUST be specified BEFORE any other <script> nodes in the <html> <head> so that 
//          the window.onnload() from the other scripts have the opportunity to overload this.
window.onload = function () {
    try {
        GetFields();
        ApplyCookie();
        OnToggleReward();
    } catch (err) {
        ShowError(err);
    }
}

// #endregion Common

// ============================================================================
// ===== Functions specific to this page.
// ============================================================================

// Get the fields we will be using multiple times.
//  NOTE: Do not use keyword "var" and the value will be global.
function GetFields() {
    Slider = document.getElementById('FieldResearch_Slider_OrderBy');
    ByTask = document.getElementById('ByTask');
    ByReward = document.getElementById('ByReward');

    Rewards_All_Check = document.getElementById('Rewards_All_Check');
    Reward_Encounter = document.getElementById('Reward_Encounter');
    Reward_Razz = document.getElementById('Reward_BerryRazz');
    Reward_Nanab = document.getElementById('Reward_BerryNanab');
    Reward_Pinap = document.getElementById('Reward_BerryPinap');
    Reward_Potion = document.getElementById('Reward_Potion');
    Reward_SuperPotion = document.getElementById('Reward_PotionSuper');
    Reward_HyperPotion = document.getElementById('Reward_PotionHyper');
    Reward_MaxPotion = document.getElementById('Reward_PotionMax');
    Reward_Revive = document.getElementById('Reward_Revive');
    Reward_MaxRevive = document.getElementById('Reward_ReviveMax');
    Reward_PokeBall = document.getElementById('Reward_BallRegular');
    Reward_GreatBall = document.getElementById('Reward_BallGreat');
    Reward_UltraBall = document.getElementById('Reward_BallUltra');
    Reward_Stardust = document.getElementById('Reward_Stardust');
    Reward_RareCandy = document.getElementById('Reward_CandyRare');
    Reward_FastTM = document.getElementById('Reward_TMFast');
    Reward_ChargedTM = document.getElementById('Reward_TMCharged');
    Reward_XP = document.getElementById('Reward_XP');
}

// Called when the chart slider is toggled.
function ToggleChart() {
    if (Slider.checked) {
        ByTask.style.display = 'none';
        ByReward.style.display = 'table';
    } else {
        ByTask.style.display = 'table';
        ByReward.style.display = 'none';
    }

    UpdateCookieSettings(CookieSettings);
}

// Called when any of the Selection Criteria changes.
function OnCriteriaChanged() {

}

function OnToggleAllRewards() {
    try {
        Reward_Encounter.checked = Rewards_All_Check.checked;
        Reward_Razz.checked = Rewards_All_Check.checked;
        Reward_Nanab.checked = Rewards_All_Check.checked;
        Reward_Pinap.checked = Rewards_All_Check.checked;
        Reward_Potion.checked = Rewards_All_Check.checked;
        Reward_SuperPotion.checked = Rewards_All_Check.checked;
        Reward_HyperPotion.checked = Rewards_All_Check.checked;
        Reward_MaxPotion.checked = Rewards_All_Check.checked;
        Reward_Revive.checked = Rewards_All_Check.checked;
        Reward_MaxRevive.checked = Rewards_All_Check.checked;
        Reward_PokeBall.checked = Rewards_All_Check.checked;
        Reward_GreatBall.checked = Rewards_All_Check.checked;
        Reward_UltraBall.checked = Rewards_All_Check.checked;
        Reward_Stardust.checked = Rewards_All_Check.checked;
        Reward_RareCandy.checked = Rewards_All_Check.checked;
        Reward_FastTM.checked = Rewards_All_Check.checked;
        Reward_ChargedTM.checked = Rewards_All_Check.checked;
        Reward_XP.checked = Rewards_All_Check.checked;
    } catch (err) {
        ShowError(err);
    }

    OnCriteriaChanged();
}

function OnToggleReward() {
    try {
        if (Reward_Encounter.checked === Reward_Razz.checked &&
            Reward_Razz.checked === Reward_Nanab.checked &&
            Reward_Nanab.checked === Reward_Pinap.checked &&
            Reward_Pinap.checked === Reward_Potion.checked &&
            Reward_Potion.checked === Reward_SuperPotion.checked &&
            Reward_SuperPotion.checked === Reward_HyperPotion.checked &&
            Reward_HyperPotion.checked === Reward_MaxPotion.checked &&
            Reward_MaxPotion.checked === Reward_Revive.checked &&
            Reward_Revive.checked === Reward_MaxRevive.checked &&
            Reward_MaxRevive.checked === Reward_PokeBall.checked &&
            Reward_PokeBall.checked === Reward_GreatBall.checked &&
            Reward_GreatBall.checked === Reward_UltraBall.checked &&
            Reward_UltraBall.checked === Reward_Stardust.checked &&
            Reward_Stardust.checked === Reward_RareCandy.checked &&
            Reward_RareCandy.checked === Reward_FastTM.checked &&
            Reward_FastTM.checked === Reward_ChargedTM.checked &&
            Reward_ChargedTM.checked === Reward_XP.checked) {
            Rewards_All_Check.indeterminate = false;
            Rewards_All_Check.checked = Reward_Encounter.checked;
        } else {
            Rewards_All_Check.indeterminate = true;
        }
    } catch (err) {
        ShowError(err);
    }

    OnCriteriaChanged();
}