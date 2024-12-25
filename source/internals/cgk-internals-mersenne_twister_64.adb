--
--  Copyright (C) 2023-2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Ada_2022;

package body CGK.Internals.Mersenne_Twister_64 is

   MM : constant := 156;
   UM : constant Unsigned_64 := 16#FFFFFFFF_80000000#;
   LM : constant Unsigned_64 := 16#00000000_7FFFFFFF#;

   MAG : constant array (Unsigned_64 range 0 .. 1) of Unsigned_64 :=
     [16#00000000_00000000#, 16#B5026F5A_A96619E9#];

   --------------
   -- Generate --
   --------------

   function Generate (Self : in out Generator) return Interfaces.Unsigned_64 is
      X : Unsigned_64;

   begin
      if Self.MTI >= NN then
         --  Generate NN words at one time

         if Self.MTI = NN + 1 then
            --  If not initialized, use default initial seed.

            Initialize (Self, 5489);
         end if;

         for J in 0 .. NN - MM - 1 loop
            X := (Self.MT (J) and UM) or (Self.MT (J + 1) and LM);
            Self.MT (J) :=
              Self.MT (J + MM) xor Shift_Right (X, 1) xor MAG (X and 16#1#);
         end loop;

         for J in NN - MM .. NN - 2 loop
            X := (Self.MT (J) and UM) or (Self.MT (J + 1) and LM);
            Self.MT (J) :=
              Self.MT (J + MM - NN)
                xor Shift_Right (X, 1) xor MAG (X and 16#1#);
         end loop;

         X := (Self.MT (NN - 1) and UM) or (Self.MT (0) and LM);
         Self.MT (NN - 1) :=
           Self.MT (MM - 1) xor Shift_Right (X, 1) xor MAG (X and 16#1#);

         Self.MTI := 0;
      end if;

      X := Self.MT (Self.MTI);
      Self.MTI:= @ + 1;

      X := @ xor (Shift_Right (X, 29) and 16#5555555555555555#);
      X := @ xor (Shift_Left (X, 17) and 16#71D67FFFEDA60000#);
      X := @ xor (Shift_Left (X, 37) and 16#FFF7EEE000000000#);
      X := @ xor Shift_Right (X, 43);

      return X;
   end Generate;

   --------------
   -- Generate --
   --------------

   function Generate (Self : in out Generator) return Interfaces.Integer_64 is
   begin
      return Integer_64 (Shift_Right (Generate (Self), 1));
   end Generate;

   -----------------
   -- Generate_EE --
   -----------------

   function Generate_EE
     (Self : in out Generator) return Interfaces.IEEE_Float_64 is
   begin
      return
        (IEEE_Float_64 (Shift_Right (Generate (Self), 12)) + 0.5)
           * (1.0 / 4503599627370496.0);
   end Generate_EE;

   -----------------
   -- Generate_IE --
   -----------------

   function Generate_IE
     (Self : in out Generator) return Interfaces.IEEE_Float_64 is
   begin
      return
        IEEE_Float_64 (Shift_Right (Generate (Self), 11))
          * (1.0 / 9007199254740992.0);
   end Generate_IE;

   -----------------
   -- Generate_II --
   -----------------

   function Generate_II
     (Self : in out Generator) return Interfaces.IEEE_Float_64 is
   begin
      return
        IEEE_Float_64 (Shift_Right (Generate (Self), 11))
          * (1.0 / 9007199254740991.0);
   end Generate_II;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
     (Self : in out Generator;
      Seed : Interfaces.Unsigned_64) is
   begin
      Self.MT (0) := Seed;
      Self.MTI := 1;

      while Self.MTI <= Self.MT'Last loop
         Self.MT (Self.MTI) :=
           6364136223846793005
             * (Self.MT (Self.MTI - 1)
                  xor (Shift_Right (Self.MT (Self.MTI - 1), 62)))
             + Unsigned_64 (Self.MTI);
         Self.MTI := @ + 1;
      end loop;
   end Initialize;

end CGK.Internals.Mersenne_Twister_64;
