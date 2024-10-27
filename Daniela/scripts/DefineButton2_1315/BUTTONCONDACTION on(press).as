on(press){
   if(Key.isDown(16))
   {
      if(_parent.teamChangeCD == true)
      {
         if(dontDoMe != true)
         {
            _parent.teamChangeCD = false;
            if(inTheTeam)
            {
               _root.Krin.friendArrayX[inTheTeam2] = 0;
               _parent.bickerPicker = inTheTeam2;
            }
            else
            {
               _root.Krin.friendArrayX[_parent.bickerPicker] = id;
               if(_parent.bickerPicker == 0)
               {
                  _parent.bickerPicker = 1;
               }
               else
               {
                  _parent.bickerPicker = 0;
               }
            }
         }
      }
      _parent.updateFriends();
   }
   else if(id >= 0)
   {
      _root.Krin.MenuPlayerSelect = id;
      _parent.updateEquip();
      _parent.updateDoll();
      _parent.updateAvs();
      _parent.updateStatus();
   }
}
