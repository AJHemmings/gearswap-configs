function runspeed_job_self_command(cmdParams, eventArgs)
  runspeed_gearinfo(cmdParams, eventArgs)
end

function runspeed_gearinfo(cmdParams, eventArgs)
  if cmdParams[1] == 'gearinfo' then
    if type(cmdParams[4]) == 'string' then
          if cmdParams[4] == 'true' then
              moving = true
          elseif cmdParams[4] == 'false' then
              moving = false
          end
      end
      if not midaction() then
          job_update()
      end
  end
end

function runspeed_job_update(cmdParams, eventArgs)
  if handle_equipping_gear then
      handle_equipping_gear(player.status)
  end

  runspeed_job_handle_equipping_gear(player.status)
end

function runspeed_job_handle_equipping_gear(status, eventArgs)
  if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
      if state.Auto_Kite.value == false and moving then
          state.Auto_Kite:set(true)
      elseif state.Auto_Kite.value == true and moving == false then
          state.Auto_Kite:set(false)
      end
  end
end

function runspeed_user_setup()
  state.Auto_Kite = M(false, 'Auto_Kite')
  moving = false
end

function runspeed_customize_idle_set(idleSet)
  --windower.add_to_chat(8, 'Customize Idle Set in progress... current AutoKite state: ' .. tostring(state.Auto_Kite.value))
  if state.Auto_Kite.value == true then
    --windower.add_to_chat(127, "runspeed_customize_idle_set: Layering on Kite gear")
    idleSet = set_combine(idleSet, sets.Kiting)
  end

  return idleSet
end