// ============================================================================
// ===== Global Variables
// ============================================================================

// #region Global Variables

// Constants: Prices in Shop
var PremiumRaidPass_Value_Qty = 1; var PremiumRaidPass_Value_Price = 100;
var MaxRevives_Value_Qty = 6; var MaxRevives_Value_Price = 180;
var MaxPotions_Value_Qty = 10; var MaxPotions_Value_Price = 200;
var PokeBalls_Value_Qty = 200; var PokeBalls_Value_Price = 800;
var Lures_Value_Qty = 8; var Lures_Value_Price = 680;
var Incubator_Value_Qty = 1; var Incubator_Value_Price = 150;
var LuckyEggs_Value_Qty = 25; var LuckyEggs_Value_Price = 1250;
var Incense_Value_Qty = 25; var Incense_Value_Price = 1250;

// Constants: Assumed Values for items that may be in boxes, but are not in Shop.
var StarPiece_AssumedValue = Incense_Value_Price / Incense_Value_Qty;
var SuperIncubator_AssumedValue = 200;
var GreatBalls_AssumedValue = PokeBalls_Value_Price / PokeBalls_Value_Qty + 3;
var UltraBalls_AssumedValue = GreatBalls_AssumedValue + 3;
var RazzBerries_AssumedValue = 1;
var NanabBerries_AssumedValue = 1;
var PinappBerries_AssumedValue = 1;
var GoldenBerries_AssumedValue = 10;

// #endregion Global Variables

// ================================================================================================
// ********** Values that should be updated each time new boxes come out. *************************
// ------------------------------------------------------------------------------------------------
var ShoppingBox_Update_Date = '12 Jan 2018';
var ShoppingBox_Update_Note = '(I have no idea what the occasion is.)';

var SpecialBox = {
    'Price': 480,
    'PremiumRaidPass': 6,
    'MaxRevives': 0,
    'MaxPotions': 0,
    'PokeBalls': 0,
    'GreatBalls': 0,
    'UltraBalls': 0,
    'Lures': 0,
    'Incubator': 0,
    'LuckyEggs': 0,
    'Incense': 3,
    'StarPiece': 0,
    'SuperIncubator': 0,
    'RazzBerries': 0,
    'NanabBerries': 0,
    'PinappBerries': 10,
    'GoldenBerries': 0,
};

var GreatBox = {
    'Price': 780,
    'PremiumRaidPass': 9,
    'MaxRevives': 0,
    'MaxPotions': 0,
    'PokeBalls': 0,
    'GreatBalls': 0,
    'UltraBalls': 0,
    'Lures': 0,
    'Incubator': 0,
    'LuckyEggs': 0,
    'Incense': 0,
    'StarPiece': 10,
    'SuperIncubator': 0,
    'RazzBerries': 0,
    'NanabBerries': 0,
    'PinappBerries': 10,
    'GoldenBerries': 0,
};

var UltraBox = {
    'Price': 1480,
    'PremiumRaidPass': 15,
    'MaxRevives': 6,
    'MaxPotions': 0,
    'PokeBalls': 0,
    'GreatBalls': 0,
    'UltraBalls': 0,
    'Lures': 0,
    'Incubator': 0,
    'LuckyEggs': 6,
    'Incense': 0,
    'StarPiece': 20,
    'SuperIncubator': 0,
    'RazzBerries': 0,
    'NanabBerries': 0,
    'PinappBerries': 0,
    'GoldenBerries': 0,
};

// ================================================================================================
// ================================================================================================

// #region Cookies

// Fields that should be saved in cookies.
var CookieSettings = {
    'PremiumRaidPass_Check': 'true',
    'MaxRevives_Check': 'true',
    'MaxPotions_Check': 'true',
    'PokeBalls_Check': 'true',
    'Lures_Check': 'true',
    'Incubator_Check': 'true',
    'LuckyEggs_Check': 'true',
    'Incense_Check': 'true',

    'StarPiece_Check': 'true',
    'SuperIncubator_Check': 'true',
    'GreatBalls_Check': 'false',
    'UltraBalls_Check': 'false',
    'RazzBerries_Check': 'false',
    'NanabBerries_Check': 'false',
    'PinappBerries_Check': 'false',
    'GoldenBerries_Check': 'false',

    'PremiumRaidPass_Qty': PremiumRaidPass_Value_Qty,
    'PremiumRaidPass_Price': PremiumRaidPass_Value_Price,
    'PremiumRaidPass_Value': PremiumRaidPass_Value_Price / PremiumRaidPass_Value_Qty,
    'MaxRevives_Qty': MaxRevives_Value_Qty,
    'MaxRevives_Price': MaxRevives_Value_Price,
    'MaxRevives_Value': MaxRevives_Value_Price / MaxRevives_Value_Qty,
    'MaxPotions_Qty': MaxPotions_Value_Qty,
    'MaxPotions_Price': MaxPotions_Value_Price,
    'MaxPotions_Value': MaxPotions_Value_Price / MaxPotions_Value_Qty,
    'PokeBalls_Qty': PokeBalls_Value_Qty,
    'PokeBalls_Price': PokeBalls_Value_Price,
    'PokeBalls_Value': PokeBalls_Value_Price / PokeBalls_Value_Qty,
    'Lures_Qty': Lures_Value_Qty,
    'Lures_Price': Lures_Value_Price,
    'Lures_Value': Lures_Value_Price / Lures_Value_Qty,
    'Incubator_Qty': Incubator_Value_Qty,
    'Incubator_Price': Incubator_Value_Price,
    'Incubator_Value': Incubator_Value_Price / Incubator_Value_Qty,
    'LuckyEggs_Qty': LuckyEggs_Value_Qty,
    'LuckyEggs_Price': LuckyEggs_Value_Price,
    'LuckyEggs_Value': LuckyEggs_Value_Price / LuckyEggs_Value_Qty,
    'Incense_Qty': Incense_Value_Qty,
    'Incense_Price': Incense_Value_Price,
    'Incense_Value': Incense_Value_Price / Incense_Value_Qty,

    'StarPiece_Value': StarPiece_AssumedValue,
    'SuperIncubator_Value': SuperIncubator_AssumedValue,
    'GreatBalls_Value': GreatBalls_AssumedValue,
    'UltraBalls_Value': UltraBalls_AssumedValue,
    'RazzBerries_Value': RazzBerries_AssumedValue,
    'NanabBerries_Value': NanabBerries_AssumedValue,
    'PinappBerries_Value': PinappBerries_AssumedValue,
    'GoldenBerries_Value': GoldenBerries_AssumedValue,
};

// Read the Cookie and apply it to the fields.
function ApplyCookie() {
    try {
        ApplyCookieSettings(CookieSettings);
    }
    catch (err) {
        ShowError(err);
    }
}

// #endregion Cookies

// Called when any non-value modifications should be done.
//  (E.G. Collapsers, javascript initial values/calculations, etc.)
function LocalScript() {
    GetFields();

    var updateDate = GetCookieSetting('ShoppingBox_Update_Date');
    Reset(updateDate !== ShoppingBox_Update_Date);
    SetCookieSetting('ShoppingBox_Update_Date', ShoppingBox_Update_Date);
}

// Get the fields we will be using multiple times.
function GetFields() {
    try {
        var AllItems_Check = document.getElementById('AllItems_Check');

        var PremiumRaidPass_Check = document.getElementById('PremiumRaidPass_Check');
        var PremiumRaidPass_Value = document.getElementById('PremiumRaidPass_Value');
        var MaxRevives_Check = document.getElementById('MaxRevives_Check');
        var MaxRevives_Value = document.getElementById('MaxRevives_Value');
        var MaxPotions_Check = document.getElementById('MaxPotions_Check');
        var MaxPotions_Value = document.getElementById('MaxPotions_Value');
        var PokeBalls_Check = document.getElementById('PokeBalls_Check');
        var PokeBalls_Value = document.getElementById('PokeBalls_Value');
        var Lures_Check = document.getElementById('Lures_Check');
        var Lures_Value = document.getElementById('Lures_Value');
        var Incubator_Check = document.getElementById('Incubator_Check');
        var Incubator_Value = document.getElementById('Incubator_Value');
        var LuckyEggs_Check = document.getElementById('LuckyEggs_Check');
        var LuckyEggs_Value = document.getElementById('LuckyEggs_Value');
        var Incense_Check = document.getElementById('Incense_Check');
        var Incense_Value = document.getElementById('Incense_Value');

        var StarPiece_Check = document.getElementById('StarPiece_Check');
        var StarPiece_Value = document.getElementById('StarPiece_Value');
        var SuperIncubator_Check = document.getElementById('SuperIncubator_Check');
        var SuperIncubator_Value = document.getElementById('SuperIncubator_Value');
        var GreatBalls_Check = document.getElementById('GreatBalls_Check');
        var GreatBalls_Value = document.getElementById('GreatBalls_Value');
        var UltraBalls_Check = document.getElementById('UltraBalls_Check');
        var UltraBalls_Value = document.getElementById('UltraBalls_Value');
        var RazzBerries_Check = document.getElementById('RazzBerries_Check');
        var RazzBerries_Value = document.getElementById('RazzBerries_Value');
        var NanabBerries_Check = document.getElementById('NanabBerries_Check');
        var NanabBerries_Value = document.getElementById('NanabBerries_Value');
        var PinappBerries_Check = document.getElementById('PinappBerries_Check');
        var PinappBerries_Value = document.getElementById('PinappBerries_Value');
        var GoldenBerries_Check = document.getElementById('GoldenBerries_Check');
        var GoldenBerries_Value = document.getElementById('GoldenBerries_Value');

        var SpecialBox_Price = document.getElementById('SpecialBox_Price');
        var SpecialBox_Total = document.getElementById('SpecialBox_Total');
        var SpecialBox_Discount = document.getElementById('SpecialBox_Discount');
        var SpecialBox_PremiumRaidPass_Qty = document.getElementById('SpecialBox_PremiumRaidPass_Qty');
        var SpecialBox_MaxRevives_Qty = document.getElementById('SpecialBox_MaxRevives_Qty');
        var SpecialBox_MaxPotions_Qty = document.getElementById('SpecialBox_MaxPotions_Qty');
        var SpecialBox_PokeBalls_Qty = document.getElementById('SpecialBox_PokeBalls_Qty');
        var SpecialBox_Lures_Qty = document.getElementById('SpecialBox_Lures_Qty');
        var SpecialBox_Incubator_Qty = document.getElementById('SpecialBox_Incubator_Qty');
        var SpecialBox_LuckyEggs_Qty = document.getElementById('SpecialBox_LuckyEggs_Qty');
        var SpecialBox_Incense_Qty = document.getElementById('SpecialBox_Incense_Qty');
        var SpecialBox_StarPiece_Qty = document.getElementById('SpecialBox_StarPiece_Qty');
        var SpecialBox_SuperIncubator_Qty = document.getElementById('SpecialBox_SuperIncubator_Qty');
        var SpecialBox_RazzBerries_Qty = document.getElementById('SpecialBox_RazzBerries_Qty');
        var SpecialBox_NanabBerries_Qty = document.getElementById('SpecialBox_NanabBerries_Qty');
        var SpecialBox_PinappBerries_Qty = document.getElementById('SpecialBox_PinappBerries_Qty');
        var SpecialBox_GoldenBerries_Qty = document.getElementById('SpecialBox_GoldenBerries_Qty');

        var GreatBox_Price = document.getElementById('Great_Price');
        var GreatBox_Total = document.getElementById('GreatBox_Total');
        var GreatBox_Discount = document.getElementById('GreatBox_Discount');
        var GreatBox_PremiumRaidPass_Qty = document.getElementById('GreatBox_PremiumRaidPass_Qty');
        var GreatBox_MaxRevives_Qty = document.getElementById('GreatBox_MaxRevives_Qty');
        var GreatBox_MaxPotions_Qty = document.getElementById('GreatBox_MaxPotions_Qty');
        var GreatBox_PokeBalls_Qty = document.getElementById('GreatBox_PokeBalls_Qty');
        var GreatBox_Lures_Qty = document.getElementById('GreatBox_Lures_Qty');
        var GreatBox_Incubator_Qty = document.getElementById('GreatBox_Incubator_Qty');
        var GreatBox_LuckyEggs_Qty = document.getElementById('GreatBox_LuckyEggs_Qty');
        var GreatBox_Incense_Qty = document.getElementById('GreatBox_Incense_Qty');
        var GreatBox_StarPiece_Qty = document.getElementById('GreatBox_StarPiece_Qty');
        var GreatBox_SuperIncubator_Qty = document.getElementById('GreatBox_SuperIncubator_Qty');
        var GreatBox_RazzBerries_Qty = document.getElementById('GreatBox_RazzBerries_Qty');
        var GreatBox_NanabBerries_Qty = document.getElementById('GreatBox_NanabBerries_Qty');
        var GreatBox_PinappBerries_Qty = document.getElementById('GreatBox_PinappBerries_Qty');
        var GreatBox_GoldenBerries_Qty = document.getElementById('GreatBox_GoldenBerries_Qty');

        var UltraBox_Price = document.getElementById('UltraBox_Price');
        var UltraBox_Total = document.getElementById('UltraBox_Total');
        var UltraBox_Discount = document.getElementById('UltraBox_Discount');
        var UltraBox_PremiumRaidPass_Qty = document.getElementById('UltraBox_PremiumRaidPass_Qty');
        var UltraBox_MaxRevives_Qty = document.getElementById('UltraBox_MaxRevives_Qty');
        var UltraBox_MaxPotions_Qty = document.getElementById('UltraBox_MaxPotions_Qty');
        var UltraBox_PokeBalls_Qty = document.getElementById('UltraBox_PokeBalls_Qty');
        var UltraBox_Lures_Qty = document.getElementById('UltraBox_Lures_Qty');
        var UltraBox_Incubator_Qty = document.getElementById('UltraBox_Incubator_Qty');
        var UltraBox_LuckyEggs_Qty = document.getElementById('UltraBox_LuckyEggs_Qty');
        var UltraBox_Incense_Qty = document.getElementById('UltraBox_Incense_Qty');
        var UltraBox_StarPiece_Qty = document.getElementById('UltraBox_StarPiece_Qty');
        var UltraBox_SuperIncubator_Qty = document.getElementById('UltraBox_SuperIncubator_Qty');
        var UltraBox_RazzBerries_Qty = document.getElementById('UltraBox_RazzBerries_Qty');
        var UltraBox_NanabBerries_Qty = document.getElementById('UltraBox_NanabBerries_Qty');
        var UltraBox_PinappBerries_Qty = document.getElementById('UltraBox_PinappBerries_Qty');
        var UltraBox_GoldenBerries_Qty = document.getElementById('UltraBox_GoldenBerries_Qty');
    }
    catch (err) {
        ShowError(err);
    }
}

// Reset all of the fields.
//  (If clearCache, also reset the cookies.)
function Reset(clearCache) {
    try {
        if (clearCache) {
            ClearCookieSettings(CookieSettings);
        }

        InitializeChecks();
        InitializeBoxes();

        ApplyCookie();

        OnCheckChanged(null);
    }
    catch (err) {
        ShowError(err);
    }
}

// Set default state of which Items should be included in calculations. 
function InitializeChecks() {
    try {
        InitialCheck(PremiumRaidPass_Check, 'PremiumRaidPass', true);
        InitialCheck(MaxRevives_Check, 'MaxRevives', true);
        InitialCheck(MaxPotions_Check, 'MaxPotions', true);
        InitialCheck(PokeBalls_Check, 'PokeBalls', true);
        InitialCheck(Lures_Check, 'Lures', true);
        InitialCheck(Incubator_Check, 'Incubator', true);
        InitialCheck(LuckyEggs_Check, 'LuckyEggs', true);
        InitialCheck(Incense_Check, 'Incense', true);
        InitialCheck(StarPiece_Check, 'StarPiece', true);
        InitialCheck(SuperIncubator_Check, 'SuperIncubator', true);
        InitialCheck(GreatBalls_Check, 'GreatBalls', true);
        InitialCheck(UltraBalls_Check, 'UltraBalls', true);
        InitialCheck(RazzBerries_Check, 'RazzBerries', false);
        InitialCheck(NanabBerries_Check, 'NanabBerries', false);
        InitialCheck(PinappBerries_Check, 'PinappBerries', false);
        InitialCheck(GoldenBerries_Check, 'GoldenBerries', false);

        UpdateAllItemsCheck();
    }
    catch (err) {
        ShowError(err);
    }
}

// Set the default state of a single checkbox, disabling rows that aren't used.
function InitialCheck(checkbox, index, checkDefault) {
    if (SpecialBox[index] === 0 && GreatBox[index] === 0 && UltraBox[index] === 0) {
        checkbox.checked = false;
        checkbox.parentNode.classList.add('DISABLED');
    } else {
        checkbox.checked = checkDefault;
    }
}

// Set the default values for each of the boxes.
function InitializeBoxes() {
    try {
        if (SpecialBox['Price'] > 0) {
            SpecialBox_Price.value = SpecialBox['Price'];
            UpdateBoxRow(SpecialBox, 'PremiumRaidPass', SpecialBox_PremiumRaidPass_Qty);
            UpdateBoxRow(SpecialBox, 'MaxRevives', SpecialBox_MaxRevives_Qty);
            UpdateBoxRow(SpecialBox, 'MaxPotions', SpecialBox_MaxPotions_Qty);
            UpdateBoxRow(SpecialBox, 'PokeBalls', SpecialBox_PokeBalls_Qty);
            UpdateBoxRow(SpecialBox, 'Lures', SpecialBox_Lures_Qty);
            UpdateBoxRow(SpecialBox, 'Incubator', SpecialBox_Incubator_Qty);
            UpdateBoxRow(SpecialBox, 'LuckyEggs', SpecialBox_LuckyEggs_Qty);
            UpdateBoxRow(SpecialBox, 'Incense', SpecialBox_Incense_Qty);
            UpdateBoxRow(SpecialBox, 'StarPiece', SpecialBox_StarPiece_Qty);
            UpdateBoxRow(SpecialBox, 'SuperIncubator', SpecialBox_SuperIncubator_Qty);
            UpdateBoxRow(SpecialBox, 'GreatBalls', SpecialBox_GreatBalls_Qty);
            UpdateBoxRow(SpecialBox, 'UltraBalls', SpecialBox_UltraBalls_Qty);
            UpdateBoxRow(SpecialBox, 'RazzBerries', SpecialBox_RazzBerries_Qty);
            UpdateBoxRow(SpecialBox, 'NanabBerries', SpecialBox_NanabBerries_Qty);
            UpdateBoxRow(SpecialBox, 'PinappBerries', SpecialBox_PinappBerries_Qty);
            UpdateBoxRow(SpecialBox, 'GoldenBerries', SpecialBox_GoldenBerries_Qty);
        } else {
            document.getElementById('SpecialBox').style.display = 'none';
        }

        if (GreatBox['Price'] > 0) {
            GreatBox_Price.value = GreatBox['Price'];
            UpdateBoxRow(GreatBox, 'PremiumRaidPass', GreatBox_PremiumRaidPass_Qty);
            UpdateBoxRow(GreatBox, 'MaxRevives', GreatBox_MaxRevives_Qty);
            UpdateBoxRow(GreatBox, 'MaxPotions', GreatBox_MaxPotions_Qty);
            UpdateBoxRow(GreatBox, 'PokeBalls', GreatBox_PokeBalls_Qty);
            UpdateBoxRow(GreatBox, 'Lures', GreatBox_Lures_Qty);
            UpdateBoxRow(GreatBox, 'Incubator', GreatBox_Incubator_Qty);
            UpdateBoxRow(GreatBox, 'LuckyEggs', GreatBox_LuckyEggs_Qty);
            UpdateBoxRow(GreatBox, 'Incense', GreatBox_Incense_Qty);
            UpdateBoxRow(GreatBox, 'StarPiece', GreatBox_StarPiece_Qty);
            UpdateBoxRow(GreatBox, 'SuperIncubator', GreatBox_SuperIncubator_Qty);
            UpdateBoxRow(GreatBox, 'GreatBalls', GreatBox_GreatBalls_Qty);
            UpdateBoxRow(GreatBox, 'UltraBalls', GreatBox_UltraBalls_Qty);
            UpdateBoxRow(GreatBox, 'RazzBerries', GreatBox_RazzBerries_Qty);
            UpdateBoxRow(GreatBox, 'NanabBerries', GreatBox_NanabBerries_Qty);
            UpdateBoxRow(GreatBox, 'PinappBerries', GreatBox_PinappBerries_Qty);
            UpdateBoxRow(GreatBox, 'GoldenBerries', GreatBox_GoldenBerries_Qty);
        } else {
            document.getElementById('GreatBox').style.display = 'none';
        }

        if (UltraBox['Price'] > 0) {
            UltraBox_Price.value = UltraBox['Price'];
            UpdateBoxRow(UltraBox, 'PremiumRaidPass', UltraBox_PremiumRaidPass_Qty);
            UpdateBoxRow(UltraBox, 'MaxRevives', UltraBox_MaxRevives_Qty);
            UpdateBoxRow(UltraBox, 'MaxPotions', UltraBox_MaxPotions_Qty);
            UpdateBoxRow(UltraBox, 'PokeBalls', UltraBox_PokeBalls_Qty);
            UpdateBoxRow(UltraBox, 'Lures', UltraBox_Lures_Qty);
            UpdateBoxRow(UltraBox, 'Incubator', UltraBox_Incubator_Qty);
            UpdateBoxRow(UltraBox, 'LuckyEggs', UltraBox_LuckyEggs_Qty);
            UpdateBoxRow(UltraBox, 'Incense', UltraBox_Incense_Qty);
            UpdateBoxRow(UltraBox, 'StarPiece', UltraBox_StarPiece_Qty);
            UpdateBoxRow(UltraBox, 'SuperIncubator', UltraBox_SuperIncubator_Qty);
            UpdateBoxRow(UltraBox, 'GreatBalls', UltraBox_GreatBalls_Qty);
            UpdateBoxRow(UltraBox, 'UltraBalls', UltraBox_UltraBalls_Qty);
            UpdateBoxRow(UltraBox, 'RazzBerries', UltraBox_RazzBerries_Qty);
            UpdateBoxRow(UltraBox, 'NanabBerries', UltraBox_NanabBerries_Qty);
            UpdateBoxRow(UltraBox, 'PinappBerries', UltraBox_PinappBerries_Qty);
            UpdateBoxRow(UltraBox, 'GoldenBerries', UltraBox_GoldenBerries_Qty);
        } else {
            document.getElementById('UltraBox').style.display = 'none';
        }
    }
    catch (err) {
        ShowError(err);
    }
}

// Updates a single row of a Box.
function UpdateBoxRow(Box, index, field) {
    if (Box[index] > 0) {
        field.value = Box[index];
    } else {
        field.value = '';
        field.parentNode.parentNode.style.display = 'none';
    }
}

// Updates the state of the AllItems checkbox.
function UpdateAllItemsCheck() {
    if (PremiumRaidPass_Check.checked
        && MaxRevives_Check.checked
        && MaxPotions_Check.checked
        && PokeBalls_Check.checked
        && Lures_Check.checked
        && Incubator_Check.checked
        && LuckyEggs_Check.checked
        && Incense_Check.checked
        && StarPiece_Check.checked
        && SuperIncubator_Check.checked
        && GreatBalls_Check.checked
        && UltraBalls_Check.checked
        && RazzBerries_Check.checked
        && NanabBerries_Check.checked
        && PinappBerries_Check.checked
        && GoldenBerries_Check.checked) {
        AllItems_Check.indeterminate = false;
        AllItems_Check.checked = true;
    }
    else if (!PremiumRaidPass_Check.checked
        && !MaxRevives_Check.checked
        && !MaxPotions_Check.checked
        && !PokeBalls_Check.checked
        && !Lures_Check.checked
        && !Incubator_Check.checked
        && !LuckyEggs_Check.checked
        && !Incense_Check.checked
        && !StarPiece_Check.checked
        && !SuperIncubator_Check.checked
        && !GreatBalls_Check.checked
        && !UltraBalls_Check.checked
        && !RazzBerries_Check.checked
        && !NanabBerries_Check.checked
        && !PinappBerries_Check.checked
        && !GoldenBerries_Check.checked) {
        AllItems_Check.indeterminate = false;
        AllItems_Check.checked = false;
    }
    else {
        AllItems_Check.indeterminate = true;
    }
}

// Write out the date it was updated.
function WriteUpdated() {
    try {
        document.write('<b>Last Updated</b>: '
            + ShoppingBox_Update_Date + ' <span class="NOTE">' + ShoppingBox_Update_Note + '</span>');
    }
    catch (err) {
        ShowError(err);
    }
}

// Called when any of the value fields are updated.
// It recalculates the Total Value and Discount for each box.
function OnValueChanged(field) {
    try {
        // This field changed, so update the cookie.
        if (field !== null) {
            UpdateCookieSetting(field.id);
        }

        // Calculate the Value
        if (GetCookieSetting('PremiumRaidPass_Value') === null)
            PremiumRaidPass_Value.value = PremiumRaidPass_Price.value / PremiumRaidPass_Qty.value;
        if (GetCookieSetting('MaxRevives_Value') === null)
            MaxRevives_Value.value = MaxRevives_Price.value / MaxRevives_Qty.value;
        if (GetCookieSetting('MaxPotions_Value') === null)
            MaxPotions_Value.value = MaxPotions_Price.value / MaxPotions_Qty.value;
        if (GetCookieSetting('PokeBalls_Value') === null)
            PokeBalls_Value.value = PokeBalls_Price.value / PokeBalls_Qty.value;
        if (GetCookieSetting('Lures_Value') === null)
            Lures_Value.value = Lures_Price.value / Lures_Qty.value;
        if (GetCookieSetting('Incubator_Value') === null)
            Incubator_Value.value = Incubator_Price.value / Incubator_Qty.value;
        if (GetCookieSetting('LuckyEggs_Value') === null)
            LuckyEggs_Value.value = LuckyEggs_Price.value / LuckyEggs_Qty.value;
        if (GetCookieSetting('Incense_Value') === null)
            Incense_Value.value = Incense_Price.value / Incense_Qty.value;

        // Calculate the amount in each of the Box's Value column.
        if (PremiumRaidPass_Check.checked) {
            if (SpecialBox_PremiumRaidPass_Qty.value !== '')
                SpecialBox_PremiumRaidPass_Value.value = SpecialBox_PremiumRaidPass_Qty.value * PremiumRaidPass_Value.value;
            if (GreatBox_PremiumRaidPass_Qty.value !== '')
                GreatBox_PremiumRaidPass_Value.value = GreatBox_PremiumRaidPass_Qty.value * PremiumRaidPass_Value.value;
            if (UltraBox_PremiumRaidPass_Qty.value !== '')
                UltraBox_PremiumRaidPass_Value.value = UltraBox_PremiumRaidPass_Qty.value * PremiumRaidPass_Value.value;
        }
        if (MaxRevives_Check.checked) {
            if (SpecialBox_MaxRevives_Qty.value !== '') SpecialBox_MaxRevives_Value.value = SpecialBox_MaxRevives_Qty.value * MaxRevives_Value.value;
            if (GreatBox_MaxRevives_Qty.value !== '') GreatBox_MaxRevives_Value.value = GreatBox_MaxRevives_Qty.value * MaxRevives_Value.value;
            if (UltraBox_MaxRevives_Qty.value !== '') UltraBox_MaxRevives_Value.value = UltraBox_MaxRevives_Qty.value * MaxRevives_Value.value;
        }
        if (MaxPotions_Check.checked) {
            if (SpecialBox_MaxPotions_Qty.value !== '') SpecialBox_MaxPotions_Value.value = SpecialBox_MaxPotions_Qty.value * MaxPotions_Value.value;
            if (GreatBox_MaxPotions_Qty.value !== '') GreatBox_MaxPotions_Value.value = GreatBox_MaxPotions_Qty.value * MaxPotions_Value.value;
            if (UltraBox_MaxPotions_Qty.value !== '') UltraBox_MaxPotions_Value.value = UltraBox_MaxPotions_Qty.value * MaxPotions_Value.value;
        }
        if (PokeBalls_Check.checked) {
            if (SpecialBox_PokeBalls_Qty.value !== '') SpecialBox_PokeBalls_Value.value = SpecialBox_PokeBalls_Qty.value * PokeBalls_Value.value;
            if (GreatBox_PokeBalls_Qty.value !== '') GreatBox_PokeBalls_Value.value = GreatBox_PokeBalls_Qty.value * PokeBalls_Value.value;
            if (UltraBox_PokeBalls_Qty.value !== '') UltraBox_PokeBalls_Value.value = UltraBox_PokeBalls_Qty.value * PokeBalls_Value.value;
        }
        if (Lures_Check.checked) {
            if (SpecialBox_Lures_Qty.value !== '') SpecialBox_Lures_Value.value = SpecialBox_Lures_Qty.value * Lures_Value.value;
            if (GreatBox_Lures_Qty.value !== '') GreatBox_Lures_Value.value = GreatBox_Lures_Qty.value * Lures_Value.value;
            if (UltraBox_Lures_Qty.value !== '') UltraBox_Lures_Value.value = UltraBox_Lures_Qty.value * Lures_Value.value;
        }
        if (Incubator_Check.checked) {
            if (SpecialBox_Incubator_Qty.value !== '') SpecialBox_Incubator_Value.value = SpecialBox_Incubator_Qty.value * Incubator_Value.value;
            if (GreatBox_Incubator_Qty.value !== '') GreatBox_Incubator_Value.value = GreatBox_Incubator_Qty.value * Incubator_Value.value;
            if (UltraBox_Incubator_Qty.value !== '') UltraBox_Incubator_Value.value = UltraBox_Incubator_Qty.value * Incubator_Value.value;
        }
        if (LuckyEggs_Check.checked) {
            if (SpecialBox_LuckyEggs_Qty.value !== '') SpecialBox_LuckyEggs_Value.value = SpecialBox_LuckyEggs_Qty.value * LuckyEggs_Value.value;
            if (GreatBox_LuckyEggs_Qty.value !== '') GreatBox_LuckyEggs_Value.value = GreatBox_LuckyEggs_Qty.value * LuckyEggs_Value.value;
            if (UltraBox_LuckyEggs_Qty.value !== '') UltraBox_LuckyEggs_Value.value = UltraBox_LuckyEggs_Qty.value * LuckyEggs_Value.value;
        }
        if (Incense_Check.checked) {
            if (SpecialBox_Incense_Qty.value !== '') SpecialBox_Incense_Value.value = SpecialBox_Incense_Qty.value * Incense_Value.value;
            if (GreatBox_Incense_Qty.value !== '') GreatBox_Incense_Value.value = GreatBox_Incense_Qty.value * Incense_Value.value;
            if (UltraBox_Incense_Qty.value !== '') UltraBox_Incense_Value.value = UltraBox_Incense_Qty.value * Incense_Value.value;
        }
        if (StarPiece_Check.checked) {
            if (SpecialBox_StarPiece_Qty.value !== '') SpecialBox_StarPiece_Value.value = SpecialBox_StarPiece_Qty.value * StarPiece_Value.value;
            if (GreatBox_StarPiece_Qty.value !== '') GreatBox_StarPiece_Value.value = GreatBox_StarPiece_Qty.value * StarPiece_Value.value;
            if (UltraBox_StarPiece_Qty.value !== '') UltraBox_StarPiece_Value.value = UltraBox_StarPiece_Qty.value * StarPiece_Value.value;
        }
        if (SuperIncubator_Check.checked) {
            if (SpecialBox_SuperIncubator_Qty.value !== '') SpecialBox_SuperIncubator_Value.value = SpecialBox_SuperIncubator_Qty.value * SuperIncubator_Value.value;
            if (GreatBox_SuperIncubator_Qty.value !== '') GreatBox_SuperIncubator_Value.value = GreatBox_SuperIncubator_Qty.value * SuperIncubator_Value.value;
            if (UltraBox_SuperIncubator_Qty.value !== '') UltraBox_SuperIncubator_Value.value = UltraBox_SuperIncubator_Qty.value * SuperIncubator_Value.value;
        }
        if (GreatBalls_Check.checked) {
            if (SpecialBox_GreatBalls_Qty.value !== '') SpecialBox_GreatBalls_Value.value = SpecialBox_GreatBalls_Qty.value * GreatBalls_Value.value;
            if (GreatBox_GreatBalls_Qty.value !== '') GreatBox_GreatBalls_Value.value = GreatBox_GreatBalls_Qty.value * GreatBalls_Value.value;
            if (UltraBox_GreatBalls_Qty.value !== '') UltraBox_GreatBalls_Value.value = UltraBox_GreatBalls_Qty.value * GreatBalls_Value.value;
        }
        if (UltraBalls_Check.checked) {
            if (SpecialBox_UltraBalls_Qty.value !== '') SpecialBox_UltraBalls_Value.value = SpecialBox_UltraBalls_Qty.value * UltraBalls_Value.value;
            if (GreatBox_UltraBalls_Qty.value !== '') GreatBox_UltraBalls_Value.value = GreatBox_UltraBalls_Qty.value * UltraBalls_Value.value;
            if (UltraBox_UltraBalls_Qty.value !== '') UltraBox_UltraBalls_Value.value = UltraBox_UltraBalls_Qty.value * UltraBalls_Value.value;
        }
        if (RazzBerries_Check.checked) {
            if (SpecialBox_RazzBerries_Qty.value !== '') SpecialBox_RazzBerries_Value.value = SpecialBox_RazzBerries_Qty.value * RazzBerries_Value.value;
            if (GreatBox_RazzBerries_Qty.value !== '') GreatBox_RazzBerries_Value.value = GreatBox_RazzBerries_Qty.value * RazzBerries_Value.value;
            if (UltraBox_RazzBerries_Qty.value !== '') UltraBox_RazzBerries_Value.value = UltraBox_RazzBerries_Qty.value * RazzBerries_Value.value;
        }
        if (NanabBerries_Check.checked) {
            if (SpecialBox_NanabBerries_Qty.value !== '') SpecialBox_NanabBerries_Value.value = SpecialBox_NanabBerries_Qty.value * NanabBerries_Value.value;
            if (GreatBox_NanabBerries_Qty.value !== '') GreatBox_NanabBerries_Value.value = GreatBox_NanabBerries_Qty.value * NanabBerries_Value.value;
            if (UltraBox_NanabBerries_Qty.value !== '') UltraBox_NanabBerries_Value.value = UltraBox_NanabBerries_Qty.value * NanabBerries_Value.value;
        }
        if (PinappBerries_Check.checked) {
            if (SpecialBox_PinappBerries_Qty.value !== '') SpecialBox_PinappBerries_Value.value = SpecialBox_PinappBerries_Qty.value * PinappBerries_Value.value;
            if (GreatBox_PinappBerries_Qty.value !== '') GreatBox_PinappBerries_Value.value = GreatBox_PinappBerries_Qty.value * PinappBerries_Value.value;
            if (UltraBox_PinappBerries_Qty.value !== '') UltraBox_PinappBerries_Value.value = UltraBox_PinappBerries_Qty.value * PinappBerries_Value.value;
        }
        if (GoldenBerries_Check.checked) {
            if (SpecialBox_GoldenBerries_Qty.value !== '') SpecialBox_GoldenBerries_Value.value = SpecialBox_GoldenBerries_Qty.value * GoldenBerries_Value.value;
            if (GreatBox_GoldenBerries_Qty.value !== '') GreatBox_GoldenBerries_Value.value = GreatBox_GoldenBerries_Qty.value * GoldenBerries_Value.value;
            if (UltraBox_GoldenBerries_Qty.value !== '') UltraBox_GoldenBerries_Value.value = UltraBox_GoldenBerries_Qty.value * GoldenBerries_Value.value;
        }

        // Calculate the Totals.
        SpecialBox_Total.value =
            (PremiumRaidPass_Check.checked ? Number(SpecialBox_PremiumRaidPass_Value.value) : 0)
            + (MaxRevives_Check.checked ? Number(SpecialBox_MaxRevives_Value.value) : 0)
            + (MaxPotions_Check.checked ? Number(SpecialBox_MaxPotions_Value.value) : 0)
            + (PokeBalls_Check.checked ? Number(SpecialBox_PokeBalls_Value.value) : 0)
            + (Lures_Check.checked ? Number(SpecialBox_Lures_Value.value) : 0)
            + (Incubator_Check.checked ? Number(SpecialBox_Incubator_Value.value) : 0)
            + (LuckyEggs_Check.checked ? Number(SpecialBox_LuckyEggs_Value.value) : 0)
            + (Incense_Check.checked ? Number(SpecialBox_Incense_Value.value) : 0)
            + (StarPiece_Check.checked ? Number(SpecialBox_StarPiece_Value.value) : 0)
            + (SuperIncubator_Check.checked ? Number(SpecialBox_SuperIncubator_Value.value) : 0)
            + (GreatBalls_Check.checked ? Number(SpecialBox_GreatBalls_Value.value) : 0)
            + (UltraBalls_Check.checked ? Number(SpecialBox_UltraBalls_Value.value) : 0)
            + (RazzBerries_Check.checked ? Number(SpecialBox_RazzBerries_Value.value) : 0)
            + (NanabBerries_Check.checked ? Number(SpecialBox_NanabBerries_Value.value) : 0)
            + (PinappBerries_Check.checked ? Number(SpecialBox_PinappBerries_Value.value) : 0)
            + (GoldenBerries_Check.checked ? Number(SpecialBox_GoldenBerries_Value.value) : 0);

        GreatBox_Total.value =
            (PremiumRaidPass_Check.checked ? Number(GreatBox_PremiumRaidPass_Value.value) : 0)
            + (MaxRevives_Check.checked ? Number(GreatBox_MaxRevives_Value.value) : 0)
            + (MaxPotions_Check.checked ? Number(GreatBox_MaxPotions_Value.value) : 0)
            + (PokeBalls_Check.checked ? Number(GreatBox_PokeBalls_Value.value) : 0)
            + (Lures_Check.checked ? Number(GreatBox_Lures_Value.value) : 0)
            + (Incubator_Check.checked ? Number(GreatBox_Incubator_Value.value) : 0)
            + (LuckyEggs_Check.checked ? Number(GreatBox_LuckyEggs_Value.value) : 0)
            + (Incense_Check.checked ? Number(GreatBox_Incense_Value.value) : 0)
            + (StarPiece_Check.checked ? Number(GreatBox_StarPiece_Value.value) : 0)
            + (SuperIncubator_Check.checked ? Number(GreatBox_SuperIncubator_Value.value) : 0)
            + (GreatBalls_Check.checked ? Number(GreatBox_GreatBalls_Value.value) : 0)
            + (UltraBalls_Check.checked ? Number(GreatBox_UltraBalls_Value.value) : 0)
            + (RazzBerries_Check.checked ? Number(GreatBox_RazzBerries_Value.value) : 0)
            + (NanabBerries_Check.checked ? Number(GreatBox_NanabBerries_Value.value) : 0)
            + (PinappBerries_Check.checked ? Number(GreatBox_PinappBerries_Value.value) : 0)
            + (GoldenBerries_Check.checked ? Number(GreatBox_GoldenBerries_Value.value) : 0);

        UltraBox_Total.value =
            (PremiumRaidPass_Check.checked ? Number(UltraBox_PremiumRaidPass_Value.value) : 0)
            + (MaxRevives_Check.checked ? Number(UltraBox_MaxRevives_Value.value) : 0)
            + (MaxPotions_Check.checked ? Number(UltraBox_MaxPotions_Value.value) : 0)
            + (PokeBalls_Check.checked ? Number(UltraBox_PokeBalls_Value.value) : 0)
            + (Lures_Check.checked ? Number(UltraBox_Lures_Value.value) : 0)
            + (Incubator_Check.checked ? Number(UltraBox_Incubator_Value.value) : 0)
            + (LuckyEggs_Check.checked ? Number(UltraBox_LuckyEggs_Value.value) : 0)
            + (Incense_Check.checked ? Number(UltraBox_Incense_Value.value) : 0)
            + (StarPiece_Check.checked ? Number(UltraBox_StarPiece_Value.value) : 0)
            + (SuperIncubator_Check.checked ? Number(UltraBox_SuperIncubator_Value.value) : 0)
            + (GreatBalls_Check.checked ? Number(UltraBox_GreatBalls_Value.value) : 0)
            + (UltraBalls_Check.checked ? Number(UltraBox_UltraBalls_Value.value) : 0)
            + (RazzBerries_Check.checked ? Number(UltraBox_RazzBerries_Value.value) : 0)
            + (NanabBerries_Check.checked ? Number(UltraBox_NanabBerries_Value.value) : 0)
            + (PinappBerries_Check.checked ? Number(UltraBox_PinappBerries_Value.value) : 0)
            + (GoldenBerries_Check.checked ? Number(UltraBox_GoldenBerries_Value.value) : 0);

        // Calculate the Discount.
        SpecialBox_Discount.value = Math.round((1 - (Number(SpecialBox_Price.value) / Number(SpecialBox_Total.value))) * 100);
        if (SpecialBox_Discount.value < 0) {
            SpecialBox_Discount.classList.remove('GOOD');
            SpecialBox_Discount.classList.add('BAD');
            SpecialBox_Discount.parentElement.classList.remove('GOOD');
            SpecialBox_Discount.parentElement.classList.add('BAD');
        }
        else {
            SpecialBox_Discount.classList.remove('BAD');
            SpecialBox_Discount.classList.add('GOOD');
            SpecialBox_Discount.parentElement.classList.remove('BAD');
            SpecialBox_Discount.parentElement.classList.add('GOOD');
        }

        GreatBox_Discount.value = Math.round((1 - (Number(GreatBox_Price.value) / Number(GreatBox_Total.value))) * 100);
        if (GreatBox_Discount.value < 0) {
            GreatBox_Discount.classList.remove('GOOD');
            GreatBox_Discount.classList.add('BAD');
            GreatBox_Discount.parentElement.classList.remove('GOOD');
            GreatBox_Discount.parentElement.classList.add('BAD');
        }
        else {
            GreatBox_Discount.classList.remove('BAD');
            GreatBox_Discount.classList.add('GOOD');
            GreatBox_Discount.parentElement.classList.remove('BAD');
            GreatBox_Discount.parentElement.classList.add('GOOD');
        }

        UltraBox_Discount.value = Math.round((1 - (Number(UltraBox_Price.value) / Number(UltraBox_Total.value))) * 100);
        if (UltraBox_Discount.value < 0) {
            UltraBox_Discount.classList.remove('GOOD');
            UltraBox_Discount.classList.add('BAD');
            UltraBox_Discount.parentElement.classList.remove('GOOD');
            UltraBox_Discount.parentElement.classList.add('BAD');
        }
        else {
            UltraBox_Discount.classList.remove('BAD');
            UltraBox_Discount.classList.add('GOOD');
            UltraBox_Discount.parentElement.classList.remove('BAD');
            UltraBox_Discount.parentElement.classList.add('GOOD');
        }
    }
    catch (err) {
        ShowError(err);
    }
}

// Called when one of the Item's checkbox it toggled.
// It enables/disables the Qty, Price and Value fields for the row and disables the corresponding row in the Boxes, then calls OnValueChanged() to recalculate.
function OnCheckChanged(checkbox) {
    try {
        if (PremiumRaidPass_Check.checked) {
            PremiumRaidPass_Qty.parentNode.classList.remove('DISABLED');
            PremiumRaidPass_Price.parentNode.classList.remove('DISABLED');
            PremiumRaidPass_Value.parentNode.classList.remove('DISABLED');
            SpecialBox_PremiumRaidPass_Value.parentNode.parentNode.classList.remove('DISABLED');
            GreatBox_PremiumRaidPass_Value.parentNode.parentNode.classList.remove('DISABLED');
            UltraBox_PremiumRaidPass_Value.parentNode.parentNode.classList.remove('DISABLED');
        }
        else {
            PremiumRaidPass_Qty.parentNode.classList.add('DISABLED');
            PremiumRaidPass_Price.parentNode.classList.add('DISABLED');
            PremiumRaidPass_Value.parentNode.classList.add('DISABLED');
            SpecialBox_PremiumRaidPass_Value.parentNode.parentNode.classList.add('DISABLED');
            GreatBox_PremiumRaidPass_Value.parentNode.parentNode.classList.add('DISABLED');
            UltraBox_PremiumRaidPass_Value.parentNode.parentNode.classList.add('DISABLED');
        }

        if (MaxRevives_Check.checked) {
            MaxRevives_Qty.parentNode.classList.remove('DISABLED');
            MaxRevives_Price.parentNode.classList.remove('DISABLED');
            MaxRevives_Value.parentNode.classList.remove('DISABLED');
            SpecialBox_MaxRevives_Value.parentNode.parentNode.classList.remove('DISABLED');
            GreatBox_MaxRevives_Value.parentNode.parentNode.classList.remove('DISABLED');
            UltraBox_MaxRevives_Value.parentNode.parentNode.classList.remove('DISABLED');
        }
        else {
            MaxRevives_Qty.parentNode.classList.add('DISABLED');
            MaxRevives_Price.parentNode.classList.add('DISABLED');
            MaxRevives_Value.parentNode.classList.add('DISABLED');
            SpecialBox_MaxRevives_Value.parentNode.parentNode.classList.add('DISABLED');
            GreatBox_MaxRevives_Value.parentNode.parentNode.classList.add('DISABLED');
            UltraBox_MaxRevives_Value.parentNode.parentNode.classList.add('DISABLED');
        }

        if (MaxPotions_Check.checked) {
            MaxPotions_Qty.parentNode.classList.remove('DISABLED');
            MaxPotions_Price.parentNode.classList.remove('DISABLED');
            MaxPotions_Value.parentNode.classList.remove('DISABLED');
            SpecialBox_MaxPotions_Value.parentNode.parentNode.classList.remove('DISABLED');
            GreatBox_MaxPotions_Value.parentNode.parentNode.classList.remove('DISABLED');
            UltraBox_MaxPotions_Value.parentNode.parentNode.classList.remove('DISABLED');
        }
        else {
            MaxPotions_Qty.parentNode.classList.add('DISABLED');
            MaxPotions_Price.parentNode.classList.add('DISABLED');
            MaxPotions_Value.parentNode.classList.add('DISABLED');
            SpecialBox_MaxPotions_Value.parentNode.parentNode.classList.add('DISABLED');
            GreatBox_MaxPotions_Value.parentNode.parentNode.classList.add('DISABLED');
            UltraBox_MaxPotions_Value.parentNode.parentNode.classList.add('DISABLED');
        }

        if (PokeBalls_Check.checked) {
            PokeBalls_Qty.parentNode.classList.remove('DISABLED');
            PokeBalls_Price.parentNode.classList.remove('DISABLED');
            PokeBalls_Value.parentNode.classList.remove('DISABLED');
            SpecialBox_PokeBalls_Value.parentNode.parentNode.classList.remove('DISABLED');
            GreatBox_PokeBalls_Value.parentNode.parentNode.classList.remove('DISABLED');
            UltraBox_PokeBalls_Value.parentNode.parentNode.classList.remove('DISABLED');
        }
        else {
            PokeBalls_Qty.parentNode.classList.add('DISABLED');
            PokeBalls_Price.parentNode.classList.add('DISABLED');
            PokeBalls_Value.parentNode.classList.add('DISABLED');
            SpecialBox_PokeBalls_Value.parentNode.parentNode.classList.add('DISABLED');
            GreatBox_PokeBalls_Value.parentNode.parentNode.classList.add('DISABLED');
            UltraBox_PokeBalls_Value.parentNode.parentNode.classList.add('DISABLED');
        }

        if (Lures_Check.checked) {
            Lures_Qty.parentNode.classList.remove('DISABLED');
            Lures_Price.parentNode.classList.remove('DISABLED');
            Lures_Value.parentNode.classList.remove('DISABLED');
            SpecialBox_Lures_Value.parentNode.parentNode.classList.remove('DISABLED');
            GreatBox_Lures_Value.parentNode.parentNode.classList.remove('DISABLED');
            UltraBox_Lures_Value.parentNode.parentNode.classList.remove('DISABLED');
        }
        else {
            Lures_Qty.parentNode.classList.add('DISABLED');
            Lures_Price.parentNode.classList.add('DISABLED');
            Lures_Value.parentNode.classList.add('DISABLED');
            SpecialBox_Lures_Value.parentNode.parentNode.classList.add('DISABLED');
            GreatBox_Lures_Value.parentNode.parentNode.classList.add('DISABLED');
            UltraBox_Lures_Value.parentNode.parentNode.classList.add('DISABLED');
        }

        if (Incubator_Check.checked) {
            Incubator_Qty.parentNode.classList.remove('DISABLED');
            Incubator_Price.parentNode.classList.remove('DISABLED');
            Incubator_Value.parentNode.classList.remove('DISABLED');
            SpecialBox_Incubator_Value.parentNode.parentNode.classList.remove('DISABLED');
            GreatBox_Incubator_Value.parentNode.parentNode.classList.remove('DISABLED');
            UltraBox_Incubator_Value.parentNode.parentNode.classList.remove('DISABLED');
        }
        else {
            Incubator_Qty.parentNode.classList.add('DISABLED');
            Incubator_Price.parentNode.classList.add('DISABLED');
            Incubator_Value.parentNode.classList.add('DISABLED');
            SpecialBox_Incubator_Value.parentNode.parentNode.classList.add('DISABLED');
            GreatBox_Incubator_Value.parentNode.parentNode.classList.add('DISABLED');
            UltraBox_Incubator_Value.parentNode.parentNode.classList.add('DISABLED');
        }

        if (LuckyEggs_Check.checked) {
            LuckyEggs_Qty.parentNode.classList.remove('DISABLED');
            LuckyEggs_Price.parentNode.classList.remove('DISABLED');
            LuckyEggs_Value.parentNode.classList.remove('DISABLED');
            SpecialBox_LuckyEggs_Value.parentNode.parentNode.classList.remove('DISABLED');
            GreatBox_LuckyEggs_Value.parentNode.parentNode.classList.remove('DISABLED');
            UltraBox_LuckyEggs_Value.parentNode.parentNode.classList.remove('DISABLED');
        }
        else {
            LuckyEggs_Qty.parentNode.classList.add('DISABLED');
            LuckyEggs_Price.parentNode.classList.add('DISABLED');
            LuckyEggs_Value.parentNode.classList.add('DISABLED');
            SpecialBox_LuckyEggs_Value.parentNode.parentNode.classList.add('DISABLED');
            GreatBox_LuckyEggs_Value.parentNode.parentNode.classList.add('DISABLED');
            UltraBox_LuckyEggs_Value.parentNode.parentNode.classList.add('DISABLED');
        }

        if (Incense_Check.checked) {
            Incense_Qty.parentNode.classList.remove('DISABLED');
            Incense_Price.parentNode.classList.remove('DISABLED');
            Incense_Value.parentNode.classList.remove('DISABLED');
            SpecialBox_Incense_Value.parentNode.parentNode.classList.remove('DISABLED');
            GreatBox_Incense_Value.parentNode.parentNode.classList.remove('DISABLED');
            UltraBox_Incense_Value.parentNode.parentNode.classList.remove('DISABLED');
        }
        else {
            Incense_Qty.parentNode.classList.add('DISABLED');
            Incense_Price.parentNode.classList.add('DISABLED');
            Incense_Value.parentNode.classList.add('DISABLED');
            SpecialBox_Incense_Value.parentNode.parentNode.classList.add('DISABLED');
            GreatBox_Incense_Value.parentNode.parentNode.classList.add('DISABLED');
            UltraBox_Incense_Value.parentNode.parentNode.classList.add('DISABLED');
        }

        if (StarPiece_Check.checked) {
            StarPiece_Value.parentNode.classList.remove('DISABLED');
            SpecialBox_StarPiece_Value.parentNode.parentNode.classList.remove('DISABLED');
            GreatBox_StarPiece_Value.parentNode.parentNode.classList.remove('DISABLED');
            UltraBox_StarPiece_Value.parentNode.parentNode.classList.remove('DISABLED');
        }
        else {
            StarPiece_Value.parentNode.classList.add('DISABLED');
            SpecialBox_StarPiece_Value.parentNode.parentNode.classList.add('DISABLED');
            GreatBox_StarPiece_Value.parentNode.parentNode.classList.add('DISABLED');
            UltraBox_StarPiece_Value.parentNode.parentNode.classList.add('DISABLED');
        }

        if (SuperIncubator_Check.checked) {
            SuperIncubator_Value.parentNode.classList.remove('DISABLED');
            SpecialBox_SuperIncubator_Value.parentNode.parentNode.classList.remove('DISABLED');
            GreatBox_SuperIncubator_Value.parentNode.parentNode.classList.remove('DISABLED');
            UltraBox_SuperIncubator_Value.parentNode.parentNode.classList.remove('DISABLED');
        }
        else {
            SuperIncubator_Value.parentNode.classList.add('DISABLED');
            SpecialBox_SuperIncubator_Value.parentNode.parentNode.classList.add('DISABLED');
            GreatBox_SuperIncubator_Value.parentNode.parentNode.classList.add('DISABLED');
            UltraBox_SuperIncubator_Value.parentNode.parentNode.classList.add('DISABLED');
        }

        if (GreatBalls_Check.checked) {
            GreatBalls_Value.parentNode.classList.remove('DISABLED');
            SpecialBox_GreatBalls_Value.parentNode.parentNode.classList.remove('DISABLED');
            GreatBox_GreatBalls_Value.parentNode.parentNode.classList.remove('DISABLED');
            UltraBox_GreatBalls_Value.parentNode.parentNode.classList.remove('DISABLED');
        }
        else {
            GreatBalls_Value.parentNode.classList.add('DISABLED');
            SpecialBox_GreatBalls_Value.parentNode.parentNode.classList.add('DISABLED');
            GreatBox_GreatBalls_Value.parentNode.parentNode.classList.add('DISABLED');
            UltraBox_GreatBalls_Value.parentNode.parentNode.classList.add('DISABLED');
        }

        if (UltraBalls_Check.checked) {
            UltraBalls_Value.parentNode.classList.remove('DISABLED');
            SpecialBox_UltraBalls_Value.parentNode.parentNode.classList.remove('DISABLED');
            GreatBox_UltraBalls_Value.parentNode.parentNode.classList.remove('DISABLED');
            UltraBox_UltraBalls_Value.parentNode.parentNode.classList.remove('DISABLED');
        }
        else {
            UltraBalls_Value.parentNode.classList.add('DISABLED');
            SpecialBox_UltraBalls_Value.parentNode.parentNode.classList.add('DISABLED');
            GreatBox_UltraBalls_Value.parentNode.parentNode.classList.add('DISABLED');
            UltraBox_UltraBalls_Value.parentNode.parentNode.classList.add('DISABLED');
        }

        if (RazzBerries_Check.checked) {
            RazzBerries_Value.parentNode.classList.remove('DISABLED');
            SpecialBox_RazzBerries_Value.parentNode.parentNode.classList.remove('DISABLED');
            GreatBox_RazzBerries_Value.parentNode.parentNode.classList.remove('DISABLED');
            UltraBox_RazzBerries_Value.parentNode.parentNode.classList.remove('DISABLED');
        }
        else {
            RazzBerries_Value.parentNode.classList.add('DISABLED');
            SpecialBox_RazzBerries_Value.parentNode.parentNode.classList.add('DISABLED');
            GreatBox_RazzBerries_Value.parentNode.parentNode.classList.add('DISABLED');
            UltraBox_RazzBerries_Value.parentNode.parentNode.classList.add('DISABLED');
        }

        if (NanabBerries_Check.checked) {
            NanabBerries_Value.parentNode.classList.remove('DISABLED');
            SpecialBox_NanabBerries_Value.parentNode.parentNode.classList.remove('DISABLED');
            GreatBox_NanabBerries_Value.parentNode.parentNode.classList.remove('DISABLED');
            UltraBox_NanabBerries_Value.parentNode.parentNode.classList.remove('DISABLED');
        }
        else {
            NanabBerries_Value.parentNode.classList.add('DISABLED');
            SpecialBox_NanabBerries_Value.parentNode.parentNode.classList.add('DISABLED');
            GreatBox_NanabBerries_Value.parentNode.parentNode.classList.add('DISABLED');
            UltraBox_NanabBerries_Value.parentNode.parentNode.classList.add('DISABLED');
        }

        if (PinappBerries_Check.checked) {
            PinappBerries_Value.parentNode.classList.remove('DISABLED');
            SpecialBox_PinappBerries_Value.parentNode.parentNode.classList.remove('DISABLED');
            GreatBox_PinappBerries_Value.parentNode.parentNode.classList.remove('DISABLED');
            UltraBox_PinappBerries_Value.parentNode.parentNode.classList.remove('DISABLED');
        }
        else {
            PinappBerries_Value.parentNode.classList.add('DISABLED');
            SpecialBox_PinappBerries_Value.parentNode.parentNode.classList.add('DISABLED');
            GreatBox_PinappBerries_Value.parentNode.parentNode.classList.add('DISABLED');
            UltraBox_PinappBerries_Value.parentNode.parentNode.classList.add('DISABLED');
        }

        if (GoldenBerries_Check.checked) {
            GoldenBerries_Value.parentNode.classList.remove('DISABLED');
            SpecialBox_GoldenBerries_Value.parentNode.parentNode.classList.remove('DISABLED');
            GreatBox_GoldenBerries_Value.parentNode.parentNode.classList.remove('DISABLED');
            UltraBox_GoldenBerries_Value.parentNode.parentNode.classList.remove('DISABLED');
        }
        else {
            GoldenBerries_Value.parentNode.classList.add('DISABLED');
            SpecialBox_GoldenBerries_Value.parentNode.parentNode.classList.add('DISABLED');
            GreatBox_GoldenBerries_Value.parentNode.parentNode.classList.add('DISABLED');
            UltraBox_GoldenBerries_Value.parentNode.parentNode.classList.add('DISABLED');
        }

        UpdateAllItemsCheck();

        OnValueChanged(checkbox);
    }
    catch (err) {
        ShowError(err);
    }
}

// Called when the Parent checkbox is toggled.
function OnAllItemsCheckChanged() {
    try {
        PremiumRaidPass_Check.checked
            = MaxRevives_Check.checked
            = MaxPotions_Check.checked
            = PokeBalls_Check.checked
            = Lures_Check.checked
            = Incubator_Check.checked
            = LuckyEggs_Check.checked
            = Incense_Check.checked
            = StarPiece_Check.checked
            = SuperIncubator_Check.checked
            = GreatBalls_Check.checked
            = UltraBalls_Check.checked
            = RazzBerries_Check.checked
            = NanabBerries_Check.checked
            = PinappBerries_Check.checked
            = GoldenBerries_Check.checked
            = AllItems_Check.checked;

        OnCheckChanged();
    }
    catch (err) {
        ShowError(err);
    }
}
