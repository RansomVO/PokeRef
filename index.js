var TitleHome = 'Pokemon Reference';
var CollapserNewsId = 'NEWS';
var CollapserSectionsId = 'SECTIONS';
var CollapserQuickAccessId = 'QUICK_ACCESS';
var CollapserRaidBossesId = 'RAID_BOSSES';
var CollapserMoveSetsId = 'MOVESETS';
var CollapserEvolutionsId = 'EVOLUTIONS';
var CollapserGameMasterId = 'GAME_MASTER';
var CollapserPokeStatsId = 'POKESTATS';

function LocalScript()
{
    try {
        if (document.title === TitleHome) {
            SetCollapser(CollapserNewsId);
            SetCollapser(CollapserSectionsId);
            SetCollapser(CollapserQuickAccessId);
            SetCollapser(CollapserRaidBossesId);
            //SetCollapser(CollapserMoveSetsId);
            //SetCollapser(CollapserEvolutionsId);
            //SetCollapser(CollapserGameMasterId);
            //SetCollapser(CollapserPokeStatsId);
        }
    } catch (err) {
        ShowError(err);
    }
}
