function ls --description 'Uses exa as a replacement for ls'
    if test (echo $argv | sed '/-/!d')
        and set _args (echo $argv | sed 'y/ /\n/;/^-/{y/A/a/;}')
    else
        set _args $argv
    end
    exa -Fh --git --group-directories-first $_args
end
