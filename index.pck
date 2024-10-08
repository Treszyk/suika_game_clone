GDPC                �                                                                         P   res://.godot/exported/133200997/export-59d1de9fae956dc174226046797394f5-ball.scn�      5      �h��_B�?���I����    T   res://.godot/exported/133200997/export-e323f4eeec509fdce76826aed4e0ceed-basket.scn  P       �      X�)��h����Sdx�    ,   res://.godot/global_script_class_cache.cfg   I      �       �Cn�\�ci5�,���    P   res://.godot/imported/CLICKABLEAREA.png-269d11273d328d26155bf233cc94e866.ctex   �6      �      Ñ�:Ϧy�*��݃$�    D   res://.godot/imported/ball.png-0f0bbcd25f06400f41d201820568b550.ctex       �      =�@{�+��L;�F��    H   res://.godot/imported/basket.png-7b352d3c1bfdc4cad0c06c7ca9af18f4.ctex         ~       �e�#-l�A#-x�A}�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctexP:            ：Qt�E�cO���       res://.godot/uid_cache.bin  pM      �       �o�gc�m\WQB�ٯʂ        res://CLICKABLEAREA.png.import  �9      �       �)�pT�CV��}=U�       res://icon.svg  �I      �      k����X3Y���f       res://icon.svg.import   pG      �       �?��`�d/jl%g�       res://project.binary`N             ���eת7�c�       res://source/SpawnArea.gd   @3      �      ���Фd�;��3>A       res://source/ball.gd              "�Hf���h�=�5��       res://source/ball.png.import       �       	:��� uˏ���k"�       res://source/ball.tscn.remap@H      a       %�\Sh;��p�G]��        res://source/basket.png.import  �      �       �Hr�[�4r�'&�3	J        res://source/basket.tscn.remap  �H      c       	2L3�X;:��i/� L�       res://source/main_ui.gd P%      w      �5����|%��[|L       res://source/main_ui.tscn   �+      h      �q�qz�GI����            extends Node2D

class_name Ball
# Variables for the ball's tier and max tier
var tier: int = 1
var max_tier: int = 20  # Define the maximum tier for the balls
var is_merging = false
# Reference the Sprite and CollisionShape2D nodes
@onready var sprite = $RigidBody2D/CollisionShape2D/Sprite2D
@onready var collision_shape = $RigidBody2D/CollisionShape2D
@onready var tier_text= $RigidBody2D/RichTextLabel
@onready var this_body = $RigidBody2D
# Called when the node enters the scene tree for the first time
func _ready():
	set_tier(tier)  # Initialize the ball with the default tier
	tier_text.add_text(String.num_int64(tier))
	var scale_factor = 2 + (tier - 1)
	print_debug(scale_factor)
	collision_shape.scale = Vector2(scale_factor, scale_factor)
	this_body.mass = 2*(tier*tier)
	
# Function to set the ball's tier and update its visuals
func set_tier(tier_value: int):
	tier = tier_value
	
	# Scale the entire Ball node (Node2D) based on its tier
	
	# Optionally change the sprite texture based on the tier (if you have different textures)
	#sprite.texture = load("res://textures/ball_tier_%d.png" % tier)

# Function to merge with another ball
func merge_with(other_ball):
	if tier < max_tier and not is_merging and not other_ball.get_parent().is_merging:
		is_merging = true
		other_ball.get_parent().is_merging = true
		print_debug('merge')
		var new_tier = tier + 1
		
		# Create a new ball of the next tier
		var new_ball = preload("res://source/ball.tscn").instantiate()  # Assuming BallScene is preloaded
		new_ball.global_position = other_ball.global_position  # Place the new ball at the same position
		new_ball.set_tier(new_tier)
		get_parent().add_child(new_ball)
		print_debug(new_ball.tier, new_ball.position)

		# Remove the old balls
		self.queue_free()
		other_ball.get_parent().queue_free()

func _on_rigid_body_2d_body_entered(body):
	print_debug(self.global_position)
	if body.is_in_group("Balls") and body.get_parent().tier == self.tier and not is_merging:
		print_debug('ball')
		merge_with(body)  # Merge the two balls if they have the same tier


     GST2            ����                        �  RIFF�  WEBPVP8L�  /��?�Ġm#I�O��f��Ͽ��mCo��mۆA�F���<� � �0�}�x�0��nX���x0MD+����a�.�d������ ޮm{�d۶s;D�J����bG��h�b����9��Ac=�C���۲���d߷�kD�%J�[�����k�~����y7���s�x�f�țُ�~�$���N����q��H�����{\��?ˆ;�2����[�I�»']�e����Jv]�p|[�4��íu�nl\��;���[�w�;v]�y�{N�=溏�t\��J�ʳ%�N.~x=t���Xա}��YY���Ukl�5��â�F��]	8.د*m�.b3>�y��@%�;G�nzk)�[�d�՘�m����v��Ŏ��{�νǮ8֪BW�C�|�V���5m�j�Xyr(lT:�N�~�Q���o;���m�ځ5ޣ��gw�v���g���Ӭ��M�ӣ�=_z�ӵwt�m}�~���|a��i��<�ҽgT."4�o�'���U��_�.廿/�w�_����0_�=/ΰ_6�e����]e��W��EV��N�k&���[��B�)���I��m�<�L�hp�⽅����5��Y�lj�p���.�s{�;��a^����E���3���Vվd�t�����+f藵\�̉,k��9��Źi:�r$��V�Ǚ_��L��7Ef;�+<^��%+��	�+_�����,?�}�2�S���S�6d����+ʍ�Y��r��X슮����P%���X��������6(�z�D4�O?+/��;�]#��Wz�i�����������{�$��:T�/��Q?��e=9_���h�W� ���X�ԃ�(BUL#A��Ep����'�p�F���i�"��?�1W��g�{QlZE*B.����|a>��j��e��2��/�Ϳ��F�$���Rh�C��9��ז�)g�J*�����#�(�.��� _٩8�X��q���".��"z,�z@�@��y\�Ly�iI]J�#4�w�vS���(����_���vR���1�I�~c3¦A�2��4r�l�:�ʆE'ـ]H���<�K[�<�3=�������BLZS�:��)4=͗��~#�I�*��?b���L!Y�n��I����@d��@��50iY g�h�QH��4˙����)4�j�r�+�?C�I+��z�X�ZJơ��ees���7^�RB��#\�Y�ÙJ�rCC\�ZC��b_��L�g���?|�Nd�1
��2iq���Y)r����̤������W�>&-�><�ק��f�J���T����D��WC�a)yj���(
,�&�B^B�cy4%P�X������:��T����`��$Q@���5A�>���N��)�vM��w�B5��)�r��Y�~&�S�_Ƀ�C�&�NBw�iJ���`�It�=�@;MYԎ�O�(�"�6�)��`�E��-3�9�����\��0t�JI�z���Uw�A��(̹BM��#��ۄƺa���j`�
8]ӔI�`�i�֙Q�N6�Q��BO/hJ�`n�
 ��@s��y��\�2��С��������88sI
��yC�^,!m�V����e$ES��`+���3�8qU.�N��⫀Ӌ��/#��G�P��JF� �\����e,�B@Ϙዒ��0�=�6��P=`s@1q���z�
�3�s+9Q�g;��I���������pVR΂�G)݆߻%e�o8dR�oI
���9B�6t�JX]��*e�8��5�$)�~�"ӆ����0doڤ�Ͱ�m�ӆi������L9��ah5&���Ið!n�'/�����mh��&�v�Re�P�)�X��;�eǦ�Q�.� 
�uۥ�ÈČ�(���)1��wJ-�cʪ���Y!1�|{S >nXT��Æ2���ix-3�7{C��j��3b�%3�`����"3-�7�p���F��G�1�9f���P%3U�o��d��׊a���3�$�2ShHl�e&� ��d&ˠ�G�?��'�?���.�����?w�1��L��͈���2���df��s��ZI+����f��Af>���2�h8~N_S �wxP!1��`8/1�J�3t*Y&w�)��3bx�T�!.1qC9~l���Y�,����mC�)��M��L��'/����aä�L����i��0����n�����[�6ii3leCӆ����0��������p9��J��Y	V�A��Y� �5gx++os��m��$d��m��w�YI9F��\2ܗ�������0�D����x��I=�|�# ��I ���1�%���0�&#-�J��$&���x#�� Pʣb��|�_0Ę�p^�K2r	,��S
V��M��'�Cx5�$�~��0�/�n������������;W>r�q�����5�����ہ���S�1eX�A�+Ҁ�+��Gs�Z��t� j�[�F��:�TY֎*���ec8��Zld��Fɔ�`�$1�M�#�x4�2[����(�2��[]^)y��W@إ���tvN*΁�3�T�\�3Q�d�4pѵ���8��.�`�8��5'���(Y��<p2	G����]��D
�C�?��f�;%���͚��Ė� S�Pr�)�q3)��èK
����I��M]փDBdp��V&��K�q,O���ʗɿ���e�%A֖k���DdC���G$gw�{���{gpǙ����U�O
����z�Ĕ-�f"�g�vXKQ�Y��� �ݯ��J���^�w�vb?��s����Ka�74Đ��aH7Ri����l����<�/��Le缜�k���:�����	}�I�u�˰��-'�p��j L�K�v]�s�Ⱥy��t�J=Y���ED�͢�x���H��1�Gd��#?����xFz�z���� �hf�����t9F�=���[YS��>�H�_���� �T��N�{����	�W��"ʆcM�?<k7��+��[�NF�Ṋ?��m�/M�Ae�� ����'�v�&�ɣ�[���H�\"�%��Q�,�z�I�?�< Z>>@e�<��Ι�l�3H��S��QN�[.��묒Sh���2DN��̅<4S3ـ}���By��n1�OMu�l����T$A6�<���{�1���Ur����	ϹBǨ���&��,��	bJ�ʃ��AJ��~4+K���yP�IC�(YQM�o/#+��>�G4����	�_ɀ3ܢ�Wf4�5�]/�y��kr�hW��ʋ&42~��F0��jcAN~�������60C��N]���
�V����~��0sU�jS��v�SSԁ�j?̯��FV����w��~:�j$��'3�Ӌ���L��U��>�����393^Nd�N=}N����;7M�^���靯��}�i�
�?��+f藵���_����Zy}�a��G����;T~S��&c�p�C��n�v�N�!}X�<�L�hP]P��B3�ơ���q��Ե\���^��L��Tv����3����2��ʺ�53�*_K��4�K��w9��)�7VN���i�5ea0����"B��`�MΕ�ӣ��/=��T[����/�L���+[�k�=�����H�Un{�}��<?��@�se�"��|�~�Q���o;�8W�)T��v����j2�AFM���!V��se���jL;��佦��cGYӽ���cW\T�*Ti˘v�����QPq�s$��籖R墲[�W�-iw����Э��cU���ge��;Tu�������.]zv%�\U\�y�{N�=溏�t�b�U|���V�ؚ�{�XYg%=�����vjَ��e+e�*�;�̲Ʈ'��g�ݓ�ƲL�{Vˆr{��y3��ۯ�Ķ�ۉ�_�>ξ�>~x�R�_��         [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://vlrtueod035n"
path="res://.godot/imported/ball.png-0f0bbcd25f06400f41d201820568b550.ctex"
metadata={
"vram_texture": false
}
 RSRC                    PackedScene            ��������                                            
      resource_local_to_scene    resource_name 	   friction    rough    bounce 
   absorbent    script    custom_solver_bias    radius 	   _bundled       Script    res://source/ball.gd ��������
   Texture2D    res://source/ball.png �.8��      local://PhysicsMaterial_1amag �         local://CircleShape2D_sujd3          local://PackedScene_p5rg6 *         PhysicsMaterial            �>         CircleShape2D             PackedScene    	      	         names "         Ball 	   position    script    Balls    Node2D    RigidBody2D    physics_material_override    max_contacts_reported    contact_monitor    RichTextLabel    offset_left    offset_top    offset_right    offset_bottom    CollisionShape2D    scale    shape 	   Sprite2D    texture    _on_rigid_body_2d_body_entered    body_entered    	   variants       
    ��C�cC                       
              ��     @�     B     �A
     �?  �?         
   
ף=
ף=               node_count             nodes     ?   ��������       ����                                    ����                                  	   	   ����   
                                         ����      	      
                    ����                         conn_count             conns                                      node_paths              editable_instances              version             RSRC           GST2            ����                        F   RIFF>   WEBPVP8L2   /���BQ�F�19����D����-����?����_/+����  [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://b3o6sw21ppp5a"
path="res://.godot/imported/basket.png-7b352d3c1bfdc4cad0c06c7ca9af18f4.ctex"
metadata={
"vram_texture": false
}
              RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled    
   Texture2D    res://source/basket.png ����j��<      local://RectangleShape2D_ogkhk �         local://RectangleShape2D_h4xpg �         local://PackedScene_xm7ko �         RectangleShape2D       
   _A��C         RectangleShape2D       
   J�C���A         PackedScene          	         names "   
      StaticBody2D2 	   position    scale    StaticBody2D 	   Sprite2D    texture    CollisionShape2D    shape    CollisionShape2D2    CollisionShape2D3    	   variants    
   
    �wD  �C
   q=@q=@
   o��PM&B
   FD�>��?          
   h�¦
B          
   ���B�
B
   �|�LwDC               node_count             nodes     9   ��������       ����                                  ����                                       ����                                 ����                              	   ����            	             conn_count              conns               node_paths              editable_instances              version             RSRC         extends Node2D

# Preload the Ball scene
var BallScene = preload("res://source/ball.tscn")
@onready var basket = $StaticBody2D2
@onready var area2d = $StaticBody2D2/Area2D  # Adjust the path according to your scene tree
@onready var basket_sprite = $StaticBody2D2/Sprite2D
# Input function to spawn balls on click

# Function to spawn a new ball
func spawn_ball():
	var new_ball = BallScene.instantiate()
	new_ball.position = get_global_mouse_position()
	#ew_ball.set_tier(1) # Start with tier 1
	add_child(new_ball)

func resize_event():
	basket.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
func _on_ready():
	get_tree().get_root().size_changed.connect(resize_event)
	area2d.area_clicked.connect(spawn_ball)
	if OS.has_feature("mobile") or OS.has_feature("web_android") or OS.has_feature("web_ios"):
		get_tree().root.content_scale_factor = 3.0
	elif OS.has_feature("pc"):
		get_tree().root.content_scale_factor = 1
	#get_tree().root.content_scale_factor = 1
	#calculate_basket_size()
	#get_tree().root.content_scale_factor = 3.0
	resize_event()
	
func calculate_basket_size():
	var screen_size = Vector2(DisplayServer.window_get_size())
	var default_screen_size = Vector2(1920,1080)
	var def_width = 250/1920
	var def_height = 650/1080
	var new_basket_size = Vector2(0.50*screen_size.x, 0.9*screen_size.y)
	var new_basket_scale = Vector2(new_basket_size.x/512, new_basket_size.y/512)
	basket.scale = new_basket_scale
	print_debug('aha', screen_size, default_screen_size, screen_size/default_screen_size, basket_sprite.texture.get_size()*basket_sprite.scale)
func _process(_delta):
	#calculate_basket_size()
	pass
	
         [gd_scene load_steps=8 format=3 uid="uid://bmmto14axrmjs"]

[ext_resource type="Script" path="res://source/main_ui.gd" id="1_fr8pn"]
[ext_resource type="PackedScene" uid="uid://cq5lnrhshp2nw" path="res://source/basket.tscn" id="2_qu0gb"]
[ext_resource type="Script" path="res://source/SpawnArea.gd" id="3_j4356"]
[ext_resource type="Texture2D" uid="uid://vlrtueod035n" path="res://source/ball.png" id="4_8rbqm"]
[ext_resource type="Texture2D" uid="uid://b5qrxxbuvjo73" path="res://CLICKABLEAREA.png" id="5_uffmr"]
[ext_resource type="PackedScene" uid="uid://b7vv8ykstwo48" path="res://source/ball.tscn" id="6_jtkei"]

[sub_resource type="RectangleShape2D" id="RectangleShape2D_lv3qr"]
size = Vector2(458, 97)

[node name="World" type="Node2D"]
script = ExtResource("1_fr8pn")

[node name="StaticBody2D2" parent="." instance=ExtResource("2_qu0gb")]
position = Vector2(974, 495)

[node name="Area2D" type="Area2D" parent="StaticBody2D2"]
position = Vector2(-16.1926, -186.871)
scale = Vector2(0.437637, 0.437637)
script = ExtResource("3_j4356")

[node name="CollisionShape2D" type="CollisionShape2D" parent="StaticBody2D2/Area2D"]
position = Vector2(34, 38.5)
shape = SubResource("RectangleShape2D_lv3qr")

[node name="Sprite2D" type="Sprite2D" parent="StaticBody2D2/Area2D"]
scale = Vector2(0.125, 0.125)
texture = ExtResource("4_8rbqm")

[node name="Sprite2D2" type="Sprite2D" parent="StaticBody2D2/Area2D"]
position = Vector2(34.0001, 38.0002)
scale = Vector2(0.669, 0.32)
texture = ExtResource("5_uffmr")

[node name="Ball" parent="." instance=ExtResource("6_jtkei")]
position = Vector2(1015, -63)

[connection signal="ready" from="." to="." method="_on_ready"]
[connection signal="mouse_entered" from="StaticBody2D2/Area2D" to="StaticBody2D2/Area2D" method="_on_mouse_entered"]
[connection signal="mouse_exited" from="StaticBody2D2/Area2D" to="StaticBody2D2/Area2D" method="_on_mouse_exited"]
        extends Area2D

# Define a signal for when the area is clicked
signal area_clicked
@onready var col = $CollisionShape2D
@onready var hover_sprite = $Sprite2D
var mouse_inside = false
func _ready():
	set_process_input(true)

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if true:
				print("Mouse clicked inside Area2D!")
				# Emit the signal to notify the parent node
				emit_signal("area_clicked")
				


func _on_mouse_entered():
	print_debug('entered')
	mouse_inside = true

func _on_mouse_exited():
	print_debug('exited')
	mouse_inside = false
	
	
func _process(_delta):
	if mouse_inside:
		hover_sprite.visible = true  # Show the hover sprite
		hover_sprite.position = get_local_mouse_position()  # Update sprite position to mouse
	else:
		hover_sprite.visible = false  # Hide the hover sprite when outside
	


    GST2   �  ,     ����               �,       ^  RIFFV  WEBPVP8LI  /��J� Ir�6��g�X �(	Iq#�n�v|�����l3��c�[ӳ�&Nv�@��z�\��ɮɶo�m#I�D9�����8����k��,�����/����C=L%Z)x�[Y�H�J�ɌՕ�o�T��.lbI.�L��c��$���&����}���k�����ȄW
��۪��W��uy�M,�1��#��"�&[D%�0�����z��M9�R#_s�Ŏ�J�e.l��81_yjq�*�'ӟrD���?8Ge��_{�e�k�d�Ey<u6�<�1e���&�����i]���6�$�Â
���&=�+��[?q�p��|[YA?��v�M*L�a�����S�\r6f���&��'-gҼ�i�����֒7�\�=uVyI���/������C+3i]�s���k.��A�-1�~
��~��[p�LE���ݑ��k�ᾣ��R�1�q�Öڀ��뱘o�볞s��t����EQ�n��*��G�<���>�i�ET�N�n#o�����cHL���l���n�l�I�*$
�>��*�Э�?k�_����_���ߧ�[����           [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://b5qrxxbuvjo73"
path="res://.godot/imported/CLICKABLEAREA.png-269d11273d328d26155bf233cc94e866.ctex"
metadata={
"vram_texture": false
}
       GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�m�m۬�}�p,��5xi�d�M���)3��$�V������3���$G�$2#�Z��v{Z�lێ=W�~� �����d�vF���h���ڋ��F����1��ڶ�i�엵���bVff3/���Vff���Ҿ%���qd���m�J�}����t�"<�,���`B �m���]ILb�����Cp�F�D�=���c*��XA6���$
2#�E.@$���A.T�p )��#L��;Ev9	Б )��D)�f(qA�r�3A�,#ѐA6��npy:<ƨ�Ӱ����dK���|��m�v�N�>��n�e�(�	>����ٍ!x��y�:��9��4�C���#�Ka���9�i]9m��h�{Bb�k@�t��:s����¼@>&�r� ��w�GA����ը>�l�;��:�
�wT���]�i]zݥ~@o��>l�|�2�Ż}�:�S�;5�-�¸ߥW�vi�OA�x��Wwk�f��{�+�h�i�
4�˰^91��z�8�(��yޔ7֛�;0����^en2�2i�s�)3�E�f��Lt�YZ���f-�[u2}��^q����P��r��v��
�Dd��ݷ@��&���F2�%�XZ!�5�.s�:�!�Њ�Ǝ��(��e!m��E$IQ�=VX'�E1oܪì�v��47�Fы�K챂D�Z�#[1-�7�Js��!�W.3׹p���R�R�Ctb������y��lT ��Z�4�729f�Ј)w��T0Ĕ�ix�\�b�9�<%�#Ɩs�Z�O�mjX �qZ0W����E�Y�ڨD!�$G�v����BJ�f|pq8��5�g�o��9�l�?���Q˝+U�	>�7�K��z�t����n�H�+��FbQ9���3g-UCv���-�n�*���E��A�҂
�Dʶ� ��WA�d�j��+�5�Ȓ���"���n�U��^�����$G��WX+\^�"�h.���M�3�e.
����MX�K,�Jfѕ*N�^�o2��:ՙ�#o�e.
��p�"<W22ENd�4B�V4x0=حZ�y����\^�J��dg��_4�oW�d�ĭ:Q��7c�ڡ��
A>��E�q�e-��2�=Ϲkh���*���jh�?4�QK��y@'�����zu;<-��|�����Y٠m|�+ۡII+^���L5j+�QK]����I �y��[�����(}�*>+���$��A3�EPg�K{��_;�v�K@���U��� gO��g��F� ���gW� �#J$��U~��-��u���������N�@���2@1��Vs���Ŷ`����Dd$R�":$ x��@�t���+D�}� \F�|��h��>�B�����B#�*6��  ��:���< ���=�P!���G@0��a��N�D�'hX�׀ "5#�l"j߸��n������w@ K�@A3�c s`\���J2�@#�_ 8�����I1�&��EN � 3T�����MEp9N�@�B���?ϓb�C��� � ��+�����N-s�M�  ��k���yA 7 �%@��&��c��� �4�{� � �����"(�ԗ�� �t�!"��TJN�2�O~� fB�R3?�������`��@�f!zD��%|��Z��ʈX��Ǐ�^�b��#5� }ى`�u�S6�F�"'U�JB/!5�>ԫ�������/��;	��O�!z����@�/�'�F�D"#��h�a �׆\-������ Xf  @ �q�`��鎊��M��T�� ���0���}�x^�����.�s�l�>�.�O��J�d/F�ě|+^�3�BS����>2S����L�2ޣm�=�Έ���[��6>���TъÞ.<m�3^iжC���D5�抺�����wO"F�Qv�ږ�Po͕ʾ��"��B��כS�p�
��E1e�������*c�������v���%'ž��&=�Y�ް>1�/E������}�_��#��|������ФT7׉����u������>����0����緗?47�j�b^�7�ě�5�7�����|t�H�Ե�1#�~��>�̮�|/y�,ol�|o.��QJ rmϘO���:��n�ϯ�1�Z��ը�u9�A������Yg��a�\���x���l���(����L��a��q��%`�O6~1�9���d�O{�Vd��	��r\�՜Yd$�,�P'�~�|Z!�v{�N�`���T����3?DwD��X3l �����*����7l�h����	;�ߚ�;h���i�0�6	>��-�/�&}% %��8���=+��N�1�Ye��宠p�kb_����$P�i�5�]��:��Wb�����������ě|��[3l����`��# -���KQ�W�O��eǛ�"�7�Ƭ�љ�WZ�:|���є9�Y5�m7�����o������F^ߋ������������������Р��Ze�>�������������?H^����&=����~�?ڭ�>���Np�3��~���J�5jk�5!ˀ�"�aM��Z%�-,�QU⃳����m����:�#��������<�o�����ۇ���ˇ/�u�S9��������ٲG}��?~<�]��?>��u��9��_7=}�����~����jN���2�%>�K�C�T���"������Ģ~$�Cc�J�I�s�? wڻU���ə��KJ7����+U%��$x�6
�$0�T����E45������G���U7�3��Z��󴘶�L�������^	dW{q����d�lQ-��u.�:{�������Q��_'�X*�e�:�7��.1�#���(� �k����E�Q��=�	�:e[����u��	�*�PF%*"+B��QKc˪�:Y��ـĘ��ʴ�b�1�������\w����n���l镲��l��i#����!WĶ��L}rեm|�{�\�<mۇ�B�HQ���m�����x�a�j9.�cRD�@��fi9O�.e�@�+�4�<�������v4�[���#bD�j��W����֢4�[>.�c�1-�R�����N�v��[�O�>��v�e�66$����P
�HQ��9���r�	5FO� �<���1f����kH���e�;����ˆB�1C���j@��qdK|
����4ŧ�f�Q��+�     [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://d3bng8kf86w0c"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
                [remap]

path="res://.godot/exported/133200997/export-59d1de9fae956dc174226046797394f5-ball.scn"
               [remap]

path="res://.godot/exported/133200997/export-e323f4eeec509fdce76826aed4e0ceed-basket.scn"
             list=Array[Dictionary]([{
"base": &"Node2D",
"class": &"Ball",
"icon": "",
"language": &"GDScript",
"path": "res://source/ball.gd"
}])
         <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 814 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H446l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z" fill="#478cbf"/><path d="M483 600c0 34 58 34 58 0v-86c0-34-58-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
              �.8��   res://source/ball.png�%�Z��@   res://source/ball.tscn����j��<   res://source/basket.png���O�˰R   res://source/basket.tscn,׾D�*-   res://source/main_ui.tscn�-ãIB�>   res://CLICKABLEAREA.png����W�~   res://icon.svgECFG      application/config/name      	   SuikaGame      application/run/main_scene$         res://source/main_ui.tscn      application/config/features(   "         4.2    GL Compatibility       application/config/icon         res://icon.svg  "   display/window/size/viewport_width      �  #   display/window/size/viewport_height      8     display/window/size/mode            display/window/stretch/mode         canvas_items   display/window/stretch/aspect         expand  #   display/window/handheld/orientation         #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility4   rendering/textures/vram_compression/import_etc2_astc         