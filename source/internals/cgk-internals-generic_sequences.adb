--
--  Copyright (C) 2023-2024, Vadim Godunko <vgodunko@gmail.com>
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Ada_2022;

with Ada.Unchecked_Deallocation;

package body CGK.Internals.Generic_Sequences is

   procedure Free is
     new Ada.Unchecked_Deallocation
          (Element_Array_Type, Element_Array_Access);

   procedure Reallocate
     (Data     : in out Element_Array_Access;
      Capacity : Index_Type'Base;
      Size     : Index_Type'Base);

   ------------
   -- Adjust --
   ------------

   overriding procedure Adjust (Self : in out Sequence) is
   begin
      if Self.Data /= null then
         Self.Data := new Element_Array_Type'(Self.Data.all);
      end if;
   end Adjust;

   ------------
   -- Append --
   ------------

   procedure Append (Self : in out Sequence; Item : Element_Type) is
   begin
      Self.Length := @ + 1;
      Reallocate (Self.Data, Self.Capacity, Self.Length);
      Self.Data (Self.Length) := Item;
   end Append;

   -----------
   -- Clear --
   -----------

   procedure Clear (Self : in out Sequence'Class) is
   begin
      Free (Self.Data);
      Self.Capacity := 0;
      Self.Length   := 0;
   end Clear;

   ------------
   -- Delete --
   ------------

   procedure Delete (Self : in out Sequence'Class; Index : Index_Type) is
   begin
      if Index not in 1 .. Self.Length then
         raise Constraint_Error;
      end if;

      Self.Data (Index .. Self.Length - 1) :=
        Self.Data (Index + 1 .. Self.Length);
      Self.Length := @ - 1;
   end Delete;

   -----------------
   -- Delete_Last --
   -----------------

   procedure Delete_Last (Self : in out Sequence'Class) is
   begin
      if Self.Length = 0 then
         raise Constraint_Error;
      end if;

      Self.Length := @ - 1;
   end Delete_Last;

   -------------
   -- Element --
   -------------

   function Element
     (Self : Sequence'Class; Index : Index_Type) return Element_Type is
   begin
      if Index not in 1 .. Self.Length then
         raise Constraint_Error;
      end if;

      return Self.Data (Index);
   end Element;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out Sequence) is
   begin
      Free (Self.Data);
   end Finalize;

   -----------
   -- First --
   -----------

   function First (Self : Sequence'Class) return Index_Type is
      pragma Unreferenced (Self);

   begin
      return 1;
   end First;

   -------------------
   -- First_Element --
   -------------------

   function First_Element (Self : Sequence'Class) return Element_Type is
   begin
      if Self.Length = 0 then
         raise Constraint_Error;
      end if;

      return Self.Data (Self.Data'First);
   end First_Element;

   --------------
   -- Is_Empty --
   --------------

   function Is_Empty (Self : Sequence'Class) return Boolean is
   begin
      return Self.Length = 0;
   end Is_Empty;

   ----------
   -- Last --
   ----------

   function Last (Self : Sequence'Class) return Index_Type'Base is
   begin
      return Self.Length;
   end Last;

   ------------------
   -- Last_Element --
   ------------------

   function Last_Element (Self : Sequence'Class) return Element_Type is
   begin
      if Self.Length = 0 then
         raise Program_Error;
      end if;

      return Self.Data (Self.Length);
   end Last_Element;

   ------------
   -- Length --
   ------------

   function Length (Self : Sequence'Class) return Count_Type is
   begin
      return Self.Length;
   end Length;

   ----------------
   -- Reallocate --
   ----------------

   procedure Reallocate
     (Data     : in out Element_Array_Access;
      Capacity : Index_Type'Base;
      Size     : Index_Type'Base)
   is
      New_Size : constant Index_Type'Base :=
        Index_Type'Max (Capacity, Size * 2);
      Aux      : Element_Array_Access := Data;

   begin
      if Size = 0 then
         return;

      elsif Data = null or else Size > Data'Last then
         Data := new Element_Array_Type (1 .. New_Size);

         if Aux /= null then
            Data (Aux'Range) := Aux.all;
            Free (Aux);
         end if;
      end if;
   end Reallocate;

   -------------
   -- Replace --
   -------------

   procedure Replace
     (Self : in out Sequence'Class; Index : Index_Type; Item : Element_Type) is
   begin
      if Index not in 1 .. Self.Length then
         raise Constraint_Error;
      end if;

      Self.Data (Index) := Item;
   end Replace;

   ------------------
   -- Set_Capacity --
   ------------------

   procedure Set_Capacity
     (Self : in out Sequence'Class; To : Index_Type'Base) is
   begin
      Self.Capacity := To;
   end Set_Capacity;

end CGK.Internals.Generic_Sequences;
