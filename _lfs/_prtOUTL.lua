if not SOUTLINES then
    print 'Not Data To Out!'; return
else
    if dat.TMRWORK then STOPBLINK() end
    for i = 1, 8 do
        max7219.bToDig(SOUTLINES[i], i)
    end
end
