local isUsed = false

RegisterNetEvent("az_carhud:showcarhud")
RegisterNetEvent("az_carhud:hidecarhud")

AddEventHandler("az_carhud:showcarhud", function(interface)
    SendNUIMessage({
        type = "carhud:show",
        velocity = interface.velocity,
        fuel = interface.fuel,
    })
end)

AddEventHandler("az_carhud:hidecarhud", function()
    SendNUIMessage({
        type = "carhud:hide",
    })
end)

CreateThread(function()
    while true do
        isUsed = false
        if (IsPedInAnyVehicle(PlayerPedId())) then
            isUsed = true
            TriggerEvent("az_carhud:showcarhud", {
                velocity = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId()))*3.6,
                fuel     = GetVehicleFuelLevel(GetVehiclePedIsIn(PlayerPedId())),
            })
        else
            TriggerEvent("az_carhud:hidecarhud")
            SetTimeout(1000, function()
                isUsed = false
            end)
        end
        if isUsed then
            Wait(140)
        else
            Wait(5000)
        end
    end
end)

--By @audaz#0001