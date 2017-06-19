local alien_move = {}
local alien_anim_frame = 1
local alien_pos_x = 630
local alien_pos_y = 370
local alien_anim_time = 0
local alien_dir= -1

local enemy_bullets = {}

local cauda = {}
cauda.anim_frame =  1
cauda.x      = alien_pos_x
cauda.y      = alien_pos_y
cauda.anim_time = 1
cauda.dir =  1

function bulletSpawn(x,y)
  table.insert(enemy_bullets, {x=x, y=y})
end

local function hipotenusa(x1, x2, y1, y2)
   local dist = math.sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1))
   return dist
   end 
function alien_move.load()
 for x=1,4,1 do
   alien_move[x] = love.graphics.newImage("alien_move_0" .. x .. ".png")
 end
 for i=1,6,1 do
   cauda[i] = love.graphics.newImage("cauda_0" .. i .. ".png")
 end
 end 
function alien_move.update(dt, girl_pos_x, girl_pos_y)
   if alien_pos_x - 125 < 0 then
      alien_pos_x = 125
     end
   d = hipotenusa(alien_pos_x, girl_pos_x, alien_pos_y, girl_pos_y)
   dir = girl_pos_x - alien_pos_x
   if dir ~= 0 then
alien_dir = dir / math.abs(dir)
 if d < 400 then
     alien_pos_x = alien_pos_x + (100*dt*alien_dir)
     alien_anim_time = alien_anim_time + dt
     if alien_anim_time > 0.2 then
       alien_anim_frame = alien_anim_frame + 1
       if alien_anim_frame > 4 then
          alien_anim_frame = 1
       end
       alien_anim_time = 0
     end 
   end 
   d2 = d / 2
  if d2 < 250 then
    cauda.dir = alien_dir
    cauda.x = alien_pos_x + (dt)
    cauda.anim_time = cauda.anim_time + dt
    if cauda.anim_time > 0.2 then
      cauda.anim_frame = cauda.anim_frame + 1
      if cauda.anim_frame > 6 then
        cauda.anim_frame = 1
      end
      cauda.anim_time = 0.0001
    end
   end 
 end
 for i=1, #enemy_bullets do
   --fazer a bullet andar
 end
end
function alien_move.keyreleased(key)
   if key == "left" or key == "right" then
     alien_anim_frame = 1
   end
  end
function alien_move.draw()
 if d < 400 then 
    love.graphics.draw(alien_move[alien_anim_frame], alien_pos_x, alien_pos_y, 0, 2.5*alien_dir, 2.5,alien_move[alien_anim_frame]:getWidth()/2, alien_move[alien_anim_frame]:getHeight ()/2)
 elseif d2 < 250 then 
      love.graphics.draw(cauda[cauda.anim_frame], alien_pos_x, alien_pos_y, 0, 2.5*cauda.dir, 2.5,cauda[cauda.anim_frame]:getWidth()/2, cauda[cauda.anim_frame]:getHeight ()/2)
    else 
       love.graphics.draw(alien_move[alien_anim_frame], alien_pos_x, alien_pos_y, 0, 2.5*alien_dir, 2.5,alien_move[alien_anim_frame]:getWidth()/2, alien_move[alien_anim_frame]:getHeight ()/2)
      end 
end
 return alien_move