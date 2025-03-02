        table.clear(cachearray);
    end;

    meta.getplainarray = function(self: table)
        local tab: table = {};
        local iter: number = 0;
        for i: Instance | number?, v: Instance? in array do
            table.insert(tab, v)
        end;
        return tab
    end;

    meta.shutdown = function(self: table)
        self:clear();
        pcall(task.cancel, cleanerthread);
        cleanerthread = nil;
        table.clear(meta);
        table.clear(onclean);
        onclean = nil;
    end;

    return array
end;

if getgenv then 
    getgenv().Performance = Performance 
end;

return Performance
