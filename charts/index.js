var TitleNamingTechnique = 'Pokemon Naming Technique';
var CollapserSortOrderId = 'SORT_ORDER';
var CollapserNumericsId = 'NUMERICS';

var TitleEffectiveness = 'Move Effectiveness';
var CollapserEffectivenessKeyId = 'EFFECTIVENESS_KEY';


function LocalScript() {
    try {
        if (document.title === TitleNamingTechnique) {
            SetCollapser(CollapserSortOrderId);
            SetCollapser(CollapserNumericsId);
        } else if (document.title === TitleEffectiveness) {
            SetCollapser(CollapserEffectivenessKeyId);
        }
    } catch (err) {
        ShowError(err);
    }
}

