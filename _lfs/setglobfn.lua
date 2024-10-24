askfl = function(t, e)
    if e then
        node.task.post(function() dofile(t)(e) end)
    else
        node.task.post(function() dofile(t) end)
    end
end
prt = function(...) if DEBUG then print(...) end end
