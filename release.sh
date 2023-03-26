while getopts v: flag
do
    case "${flag}" in
        v) version=${OPTARG:?Need value};;
    esac
done

# version=$(awk '/^## AddOnVersion/{print $NF}' GroupActivityFinderExtensions.txt)

$output = build/CombatExtensions

mkdir $output

cp -r src $output
cp main.lua  $output
cp vars.lua  $output
cp settings-menu.lua  $output

zip $output-$version.zip -r $output
rm -rf $output
