$src = "C:\Users\RansomV\OneDrive\ʭPokemon\PogoAssets\pokemon_icons";
$dest = "C:\Users\RansomV\OneDrive\ʭPokemon\www\images\pokemon";

$form_alolan = 61;
$forms = @{
    201 = "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "exclamation", "question";
    327 = "pattern1", "pattern2", "pattern3", "pattern4", "pattern5", "pattern6", "pattern7", "pattern8", "pattern9";
    351 = "normal", "sunny", "rainy", "snowy";
    386 = "normal", "attack", "defense", "speed";
    412 = "plant", "sandy", "trash";
    413 = "plant", "sandy", "trash";
    421 = "overcast", "sunny";
    422 = "westsea", "eastsea";
    423 = "westsea", "eastsea";
    479 = "normal", "frost", "mow", "wash", "heat", "fan";
    487 = "altered", "origin";
    492 = "land", "sky";
    493 = "unknown", "fighting", "flying", "poison", "ground", "rock", "bug", "ghost", "steel", "fire", "water", "grass", "electric", "psychic", "ice", "dragon", "dark", "fairy";
#    550
#    555
#    585
#    586
#    641
#    642
#    645
#    646
#    647
#    648
#    649
#    658
#    666
#    669
#    670
#    671
#    676
#    681
#    710
#    711
#    716
#    718
#    720
#    741
#    745
#    746
#    773
#    774
#    778
};


foreach ($i in 1..1000) {
    if ($i -eq 891 -or $i -eq 892) { continue }
        
    $id="{0:000}" -f $i

    # Make sure the icon for the Pokemon is available.
    $mon = "pokemon_icon_$($id)_00.png"
    if ((Get-ChildItem $src -Filter $mon) -ne $null) {
        # Copy over the icons for the Generic version of the Pokemon.
        $mon_shiny = "pokemon_icon_$($id)_00_shiny.png"
        Copy-Item "$src\$mon" -Destination "$dest\$id.png"
        Copy-Item "$src\$mon_shiny" -Destination "$dest\$id.shiny.png"

        # See if there is an icon for the Female version of the Pokemon.
        $female = "pokemon_icon_$($id)_01.png"
        if ((Get-ChildItem $src -Filter $female) -ne $null) {
            # Copy over the icons for the Male and Female versions of the Pokemon.
            $female_shiny = "pokemon_icon_$($id)_01_shiny.png"
            Copy-Item "$src\$mon" -Destination "$dest\$id.♂.png"
            Copy-Item "$src\$mon_shiny" -Destination "$dest\$id.♂.shiny.png"
            Copy-Item "$src\$female" -Destination "$dest\$id.♀.png"
            Copy-Item "$src\$female_shiny" -Destination "$dest\$id.♀.shiny.png"
        }

        # Special case: Alolan
        $mon_alolan = "pokemon_icon_$($id)_$($form_alolan).png"
        if ((Get-ChildItem $src -Filter $mon_alolan) -ne $null) {
            $mon_alolan_shiny = "pokemon_icon_$($id)_$($form_alolan)_shiny.png"
            Copy-Item "$src\$mon_alolan" -Destination "$dest\$($id).alolan.png"
            Copy-Item "$src\$mon_alolan_shiny" -Destination "$dest\$($id).alolan.shiny.png"

            $female_alolan = "pokemon_icon_$($id)_$($form_alolan)_01.png"
            if ((Get-ChildItem $src -Filter $female_alolan) -ne $null) {
                # Copy over the icons for the Male and Female versions of the Pokemon.
                $female_alolan_shiny = "pokemon_icon_$($id)_$($form_alolan)_01_shiny.png"
                Copy-Item "$src\$mon_alolan" -Destination "$dest\$id.♂.alolan.png"
                Copy-Item "$src\$mon_alolan_shiny" -Destination "$dest\$id.♂.alolan.shiny.png"
                Copy-Item "$src\$female_alolan" -Destination "$dest\$id.♀.alolan.png"
                Copy-Item "$src\$female_alolan_shiny" -Destination "$dest\$id.♀.alolan.shiny.png"
            }
        }

        # See if there are different Forms of the Pokemon
        if ($forms[$i] -ne $null) {
            foreach ($j in 0..(($forms[$i]).Count - 1)) {
                $form = $forms[$i][$j];
                $mon_form = "pokemon_icon_$($id)_$($j+11).png"
                if ((Get-ChildItem $src -Filter $mon_form) -ne $null) {
                    Copy-Item "$src\$mon_form" -Destination "$dest\$($id).$($form).png"
                } else {
                    Copy-Item "$src\pokemon_icon_$($id)_00.png" -Destination "$dest\$($id).$($form).png"
                }
            }
        }
    }
}
