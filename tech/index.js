var TitleMoveSets = 'Move Set Formulas';
var CollapserDamageId = 'DAMAGE';
var CollapserDPSId = 'DPS';
var CollapserTrueDPSId = 'TRUE_DPS';
var CollapserMovesetDPSId = 'MOVESET_DPS';

function LocalScript() {
    try {
        if (document.title === TitleMoveSets) {
            SetCollapser(CollapserDamageId);
            SetCollapser(CollapserDPSId);
            SetCollapser(CollapserTrueDPSId);
            SetCollapser(CollapserMovesetDPSId);
        }
    } catch (err) {
        ShowError(err);
    }
}
