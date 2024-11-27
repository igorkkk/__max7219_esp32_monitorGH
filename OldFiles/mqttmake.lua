return function(subscribe, merror, msg)
    -- m = mqtt.Client(dat.clnt, 30, dat.clnt, 'superpass')
    m = mqtt.Client(dat.clnt, 30, dat.mqlgin, dat.mqpass)
    m:lwt(dat.clnt..'/state', "Off", 0, 1)
    m:on("offline", merror)
    m:on("message", msg)
    print('Connect to', dat.brk)
    m:connect(dat.brk, dat.port, 0, subscribe, merror)
end 