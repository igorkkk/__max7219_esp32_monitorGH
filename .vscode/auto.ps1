$lfsSize  = 0x010000
#$lfsSize  = 131072

switch ($args[0]) {
    1 {
        $fpath = "./.output/lfs.img"
        $isFile = Test-Path $fpath
        if($isfile) {
            Remove-Item -Path $fpath
        }
        luac.cross.exe -o $args[1] -f -m $lfsSize -l $args[3] | Out-file $args[4]
        $isFile = Test-Path $fpath
        if($isfile) {
            curl.exe -T $args[1] --config $args[2] --ftp-pasv --disable-epsv --progress-bar  --list-only
            curl.exe --config $args[2] --ftp-pasv --disable-epsv -Q "LFS"  --list-only
        }
        else {
            Write-Warning("Compile error")
        }
        break
    }
    2 {
        $var =  "node.LFS.reload('lfs.img')"
        $fpath = "./.output/lfs.img"
        $isFile = Test-Path $fpath
        if($isfile) {
            Remove-Item -Path $fpath
        }
        luac.cross.exe -o $args[2] -f -m $lfsSize -l $args[3] | Out-file $args[4]
        $isFile = Test-Path $fpath
        if($isfile) {
            nodemcu-tool upload  $args[1] $args[2]
            $var | nodemcu-tool terminal $args[1]
        }
        else {
            Write-Warning("Compile error")
        }
       break
    }
    3 {
        $fpath = $args[2]
        $isFile = Test-Path $fpath
        if($isfile) {
            Remove-Item -Path $fpath
        }
        luac.cross.exe -o $args[2] -l $args[3] | Out-file $args[4]
        $isFile = Test-Path $fpath
        if($isfile) {
            nodemcu-tool upload  $args[1] $args[2]
            nodemcu-tool terminal --run $args[5] $args[1]
        }
        else {
            Write-Warning("Compile error")
        }
        break
    }
    4 {
        $fpath = $args[2]
        $isFile = Test-Path $fpath
        if($isfile) {
            Remove-Item -Path $fpath
        }
        luac.cross.exe -o $args[2] -l $args[3] | Out-file $args[4]
        $isFile = Test-Path $fpath
        if($isfile) {
        nodemcu-tool upload  $args[1] $args[2]
        nodemcu-tool run $args[1] $args[5]
        }
        else {
            Write-Warning("Compile error")
        }
        break
    }
    5 {
        $fpath = "./.output/lfs.img"
        $varinp = "./_lfs/*.lua"
        $isFile = Test-Path $fpath
        if($isfile) {
            Remove-Item -Path $fpath
        }
        luac.cross.exe -o $args[1] -f -m $lfsSize -l $varinp | Out-file $args[2]
        $isFile = Test-Path $fpath
        if($isfile) {
            Write-Output("Compiled Now!")
        }
        else {
            Write-Warning("Compile error now")
        }
       break
    }
}
exit
