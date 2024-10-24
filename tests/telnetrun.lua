tmr.create():alarm(60000, tmr.ALARM_AUTO, function(t)
    t:stop()
    t:unregister()
    t = nil
    print('\t\t\t\t\t\tAsk Telnet by Timer')
    node.task.post(function() dofile'telnet2.lua' end)
end)