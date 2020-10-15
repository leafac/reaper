from reaper_python import *

def BR_EnvAlloc(p0,p1):
  a=rpr_getfp('BR_EnvAlloc')
  f=CFUNCTYPE(c_uint64,c_uint64,c_byte)(a)
  t=(rpr_packp('TrackEnvelope*',p0),c_byte(p1))
  r=f(t[0],t[1])
  return rpr_unpackp('BR_Envelope*',r)

def BR_EnvCountPoints(p0):
  a=rpr_getfp('BR_EnvCountPoints')
  f=CFUNCTYPE(c_int,c_uint64)(a)
  t=(rpr_packp('BR_Envelope*',p0),)
  r=f(t[0])
  return r

def BR_EnvDeletePoint(p0,p1):
  a=rpr_getfp('BR_EnvDeletePoint')
  f=CFUNCTYPE(c_byte,c_uint64,c_int)(a)
  t=(rpr_packp('BR_Envelope*',p0),c_int(p1))
  r=f(t[0],t[1])
  return r

def BR_EnvFind(p0,p1,p2):
  a=rpr_getfp('BR_EnvFind')
  f=CFUNCTYPE(c_int,c_uint64,c_double,c_double)(a)
  t=(rpr_packp('BR_Envelope*',p0),c_double(p1),c_double(p2))
  r=f(t[0],t[1],t[2])
  return r

def BR_EnvFindNext(p0,p1):
  a=rpr_getfp('BR_EnvFindNext')
  f=CFUNCTYPE(c_int,c_uint64,c_double)(a)
  t=(rpr_packp('BR_Envelope*',p0),c_double(p1))
  r=f(t[0],t[1])
  return r

def BR_EnvFindPrevious(p0,p1):
  a=rpr_getfp('BR_EnvFindPrevious')
  f=CFUNCTYPE(c_int,c_uint64,c_double)(a)
  t=(rpr_packp('BR_Envelope*',p0),c_double(p1))
  r=f(t[0],t[1])
  return r

def BR_EnvFree(p0,p1):
  a=rpr_getfp('BR_EnvFree')
  f=CFUNCTYPE(c_byte,c_uint64,c_byte)(a)
  t=(rpr_packp('BR_Envelope*',p0),c_byte(p1))
  r=f(t[0],t[1])
  return r

def BR_EnvGetParentTake(p0):
  a=rpr_getfp('BR_EnvGetParentTake')
  f=CFUNCTYPE(c_uint64,c_uint64)(a)
  t=(rpr_packp('BR_Envelope*',p0),)
  r=f(t[0])
  return rpr_unpackp('MediaItem_Take*',r)

def BR_EnvGetParentTrack(p0):
  a=rpr_getfp('BR_EnvGetParentTrack')
  f=CFUNCTYPE(c_uint64,c_uint64)(a)
  t=(rpr_packp('BR_Envelope*',p0),)
  r=f(t[0])
  return rpr_unpackp('MediaItem*',r)

def BR_EnvGetPoint(p0,p1,p2,p3,p4,p5,p6):
  a=rpr_getfp('BR_EnvGetPoint')
  f=CFUNCTYPE(c_byte,c_uint64,c_int,c_void_p,c_void_p,c_void_p,c_void_p,c_void_p)(a)
  t=(rpr_packp('BR_Envelope*',p0),c_int(p1),c_double(p2),c_double(p3),c_int(p4),c_byte(p5),c_double(p6))
  r=f(t[0],t[1],byref(t[2]),byref(t[3]),byref(t[4]),byref(t[5]),byref(t[6]))
  return (r,p0,p1,float(t[2].value),float(t[3].value),int(t[4].value),int(t[5].value),float(t[6].value))

def BR_EnvGetProperties(p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11):
  a=rpr_getfp('BR_EnvGetProperties')
  f=CFUNCTYPE(None,c_uint64,c_void_p,c_void_p,c_void_p,c_void_p,c_void_p,c_void_p,c_void_p,c_void_p,c_void_p,c_void_p,c_void_p)(a)
  t=(rpr_packp('BR_Envelope*',p0),c_byte(p1),c_byte(p2),c_byte(p3),c_byte(p4),c_int(p5),c_int(p6),c_double(p7),c_double(p8),c_double(p9),c_int(p10),c_byte(p11))
  f(t[0],byref(t[1]),byref(t[2]),byref(t[3]),byref(t[4]),byref(t[5]),byref(t[6]),byref(t[7]),byref(t[8]),byref(t[9]),byref(t[10]),byref(t[11]))
  return (p0,int(t[1].value),int(t[2].value),int(t[3].value),int(t[4].value),int(t[5].value),int(t[6].value),float(t[7].value),float(t[8].value),float(t[9].value),int(t[10].value),int(t[11].value))

def BR_EnvSetPoint(p0,p1,p2,p3,p4,p5,p6):
  a=rpr_getfp('BR_EnvSetPoint')
  f=CFUNCTYPE(c_byte,c_uint64,c_int,c_double,c_double,c_int,c_byte,c_double)(a)
  t=(rpr_packp('BR_Envelope*',p0),c_int(p1),c_double(p2),c_double(p3),c_int(p4),c_byte(p5),c_double(p6))
  r=f(t[0],t[1],t[2],t[3],t[4],t[5],t[6])
  return r

def BR_EnvSetProperties(p0,p1,p2,p3,p4,p5,p6,p7):
  a=rpr_getfp('BR_EnvSetProperties')
  f=CFUNCTYPE(None,c_uint64,c_byte,c_byte,c_byte,c_byte,c_int,c_int,c_byte)(a)
  t=(rpr_packp('BR_Envelope*',p0),c_byte(p1),c_byte(p2),c_byte(p3),c_byte(p4),c_int(p5),c_int(p6),c_byte(p7))
  f(t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7])

def BR_EnvSortPoints(p0):
  a=rpr_getfp('BR_EnvSortPoints')
  f=CFUNCTYPE(None,c_uint64)(a)
  t=(rpr_packp('BR_Envelope*',p0),)
  f(t[0])

def BR_EnvValueAtPos(p0,p1):
  a=rpr_getfp('BR_EnvValueAtPos')
  f=CFUNCTYPE(c_double,c_uint64,c_double)(a)
  t=(rpr_packp('BR_Envelope*',p0),c_double(p1))
  r=f(t[0],t[1])
  return r

def BR_GetArrangeView(p0,p1,p2):
  a=rpr_getfp('BR_GetArrangeView')
  f=CFUNCTYPE(None,c_uint64,c_void_p,c_void_p)(a)
  t=(rpr_packp('ReaProject*',p0),c_double(p1),c_double(p2))
  f(t[0],byref(t[1]),byref(t[2]))
  return (p0,float(t[1].value),float(t[2].value))

def BR_GetClosestGridDivision(p0):
  a=rpr_getfp('BR_GetClosestGridDivision')
  f=CFUNCTYPE(c_double,c_double)(a)
  t=(c_double(p0),)
  r=f(t[0])
  return r

def BR_GetCurrentTheme(p0,p1,p2,p3):
  a=rpr_getfp('BR_GetCurrentTheme')
  f=CFUNCTYPE(None,c_char_p,c_int,c_char_p,c_int)(a)
  t=(rpr_packs(p0),c_int(p1),rpr_packs(p2),c_int(p3))
  f(t[0],t[1],t[2],t[3])
  return (rpr_unpacks(t[0]),p1,rpr_unpacks(t[2]),p3)

def BR_GetMediaItemByGUID(p0,p1):
  a=rpr_getfp('BR_GetMediaItemByGUID')
  f=CFUNCTYPE(c_uint64,c_uint64,c_char_p)(a)
  t=(rpr_packp('ReaProject*',p0),rpr_packsc(p1))
  r=f(t[0],t[1])
  return rpr_unpackp('MediaItem*',r)

def BR_GetMediaItemGUID(p0,p1,p2):
  a=rpr_getfp('BR_GetMediaItemGUID')
  f=CFUNCTYPE(None,c_uint64,c_char_p,c_int)(a)
  t=(rpr_packp('MediaItem*',p0),rpr_packs(p1),c_int(p2))
  f(t[0],t[1],t[2])
  return (p0,rpr_unpacks(t[1]),p2)

def BR_GetMediaItemImageResource(p0,p1,p2,p3):
  a=rpr_getfp('BR_GetMediaItemImageResource')
  f=CFUNCTYPE(c_byte,c_uint64,c_char_p,c_int,c_void_p)(a)
  t=(rpr_packp('MediaItem*',p0),rpr_packs(p1),c_int(p2),c_int(p3))
  r=f(t[0],t[1],t[2],byref(t[3]))
  return (r,p0,rpr_unpacks(t[1]),p2,int(t[3].value))

def BR_GetMediaItemTakeGUID(p0,p1,p2):
  a=rpr_getfp('BR_GetMediaItemTakeGUID')
  f=CFUNCTYPE(None,c_uint64,c_char_p,c_int)(a)
  t=(rpr_packp('MediaItem_Take*',p0),rpr_packs(p1),c_int(p2))
  f(t[0],t[1],t[2])
  return (p0,rpr_unpacks(t[1]),p2)

def BR_GetMediaSourceProperties(p0,p1,p2,p3,p4,p5):
  a=rpr_getfp('BR_GetMediaSourceProperties')
  f=CFUNCTYPE(c_byte,c_uint64,c_void_p,c_void_p,c_void_p,c_void_p,c_void_p)(a)
  t=(rpr_packp('MediaItem_Take*',p0),c_byte(p1),c_double(p2),c_double(p3),c_double(p4),c_byte(p5))
  r=f(t[0],byref(t[1]),byref(t[2]),byref(t[3]),byref(t[4]),byref(t[5]))
  return (r,p0,int(t[1].value),float(t[2].value),float(t[3].value),float(t[4].value),int(t[5].value))

def BR_GetMediaTrackByGUID(p0,p1):
  a=rpr_getfp('BR_GetMediaTrackByGUID')
  f=CFUNCTYPE(c_uint64,c_uint64,c_char_p)(a)
  t=(rpr_packp('ReaProject*',p0),rpr_packsc(p1))
  r=f(t[0],t[1])
  return rpr_unpackp('MediaTrack*',r)

def BR_GetMediaTrackFreezeCount(p0):
  a=rpr_getfp('BR_GetMediaTrackFreezeCount')
  f=CFUNCTYPE(c_int,c_uint64)(a)
  t=(rpr_packp('MediaTrack*',p0),)
  r=f(t[0])
  return r

def BR_GetMediaTrackGUID(p0,p1,p2):
  a=rpr_getfp('BR_GetMediaTrackGUID')
  f=CFUNCTYPE(None,c_uint64,c_char_p,c_int)(a)
  t=(rpr_packp('MediaTrack*',p0),rpr_packs(p1),c_int(p2))
  f(t[0],t[1],t[2])
  return (p0,rpr_unpacks(t[1]),p2)

def BR_GetMediaTrackLayouts(p0,p1,p2,p3,p4):
  a=rpr_getfp('BR_GetMediaTrackLayouts')
  f=CFUNCTYPE(None,c_uint64,c_char_p,c_int,c_char_p,c_int)(a)
  t=(rpr_packp('MediaTrack*',p0),rpr_packs(p1),c_int(p2),rpr_packs(p3),c_int(p4))
  f(t[0],t[1],t[2],t[3],t[4])
  return (p0,rpr_unpacks(t[1]),p2,rpr_unpacks(t[3]),p4)

def BR_GetMediaTrackSendInfo_Envelope(p0,p1,p2,p3):
  a=rpr_getfp('BR_GetMediaTrackSendInfo_Envelope')
  f=CFUNCTYPE(c_uint64,c_uint64,c_int,c_int,c_int)(a)
  t=(rpr_packp('MediaTrack*',p0),c_int(p1),c_int(p2),c_int(p3))
  r=f(t[0],t[1],t[2],t[3])
  return rpr_unpackp('TrackEnvelope*',r)

def BR_GetMediaTrackSendInfo_Track(p0,p1,p2,p3):
  a=rpr_getfp('BR_GetMediaTrackSendInfo_Track')
  f=CFUNCTYPE(c_uint64,c_uint64,c_int,c_int,c_int)(a)
  t=(rpr_packp('MediaTrack*',p0),c_int(p1),c_int(p2),c_int(p3))
  r=f(t[0],t[1],t[2],t[3])
  return rpr_unpackp('MediaTrack*',r)

def BR_GetMidiSourceLenPPQ(p0):
  a=rpr_getfp('BR_GetMidiSourceLenPPQ')
  f=CFUNCTYPE(c_double,c_uint64)(a)
  t=(rpr_packp('MediaItem_Take*',p0),)
  r=f(t[0])
  return r

def BR_GetMidiTakePoolGUID(p0,p1,p2):
  a=rpr_getfp('BR_GetMidiTakePoolGUID')
  f=CFUNCTYPE(c_byte,c_uint64,c_char_p,c_int)(a)
  t=(rpr_packp('MediaItem_Take*',p0),rpr_packs(p1),c_int(p2))
  r=f(t[0],t[1],t[2])
  return (r,p0,rpr_unpacks(t[1]),p2)

def BR_GetMidiTakeTempoInfo(p0,p1,p2,p3,p4):
  a=rpr_getfp('BR_GetMidiTakeTempoInfo')
  f=CFUNCTYPE(c_byte,c_uint64,c_void_p,c_void_p,c_void_p,c_void_p)(a)
  t=(rpr_packp('MediaItem_Take*',p0),c_byte(p1),c_double(p2),c_int(p3),c_int(p4))
  r=f(t[0],byref(t[1]),byref(t[2]),byref(t[3]),byref(t[4]))
  return (r,p0,int(t[1].value),float(t[2].value),int(t[3].value),int(t[4].value))

def BR_GetMouseCursorContext(p0,p1,p2,p3,p4,p5):
  a=rpr_getfp('BR_GetMouseCursorContext')
  f=CFUNCTYPE(None,c_char_p,c_int,c_char_p,c_int,c_char_p,c_int)(a)
  t=(rpr_packs(p0),c_int(p1),rpr_packs(p2),c_int(p3),rpr_packs(p4),c_int(p5))
  f(t[0],t[1],t[2],t[3],t[4],t[5])
  return (rpr_unpacks(t[0]),p1,rpr_unpacks(t[2]),p3,rpr_unpacks(t[4]),p5)

def BR_GetMouseCursorContext_Envelope(p0):
  a=rpr_getfp('BR_GetMouseCursorContext_Envelope')
  f=CFUNCTYPE(c_uint64,c_void_p)(a)
  t=(c_byte(p0),)
  r=f(byref(t[0]))
  return (rpr_unpackp('TrackEnvelope*',r),int(t[0].value))

def BR_GetMouseCursorContext_Item():
  a=rpr_getfp('BR_GetMouseCursorContext_Item')
  f=CFUNCTYPE(c_uint64)(a)
  r=f()
  return rpr_unpackp('MediaItem*',r)

def BR_GetMouseCursorContext_MIDI(p0,p1,p2,p3,p4):
  a=rpr_getfp('BR_GetMouseCursorContext_MIDI')
  f=CFUNCTYPE(c_uint64,c_void_p,c_void_p,c_void_p,c_void_p,c_void_p)(a)
  t=(c_byte(p0),c_int(p1),c_int(p2),c_int(p3),c_int(p4))
  r=f(byref(t[0]),byref(t[1]),byref(t[2]),byref(t[3]),byref(t[4]))
  return (rpr_unpackp('void*',r),int(t[0].value),int(t[1].value),int(t[2].value),int(t[3].value),int(t[4].value))

def BR_GetMouseCursorContext_Position():
  a=rpr_getfp('BR_GetMouseCursorContext_Position')
  f=CFUNCTYPE(c_double)(a)
  r=f()
  return r

def BR_GetMouseCursorContext_StretchMarker():
  a=rpr_getfp('BR_GetMouseCursorContext_StretchMarker')
  f=CFUNCTYPE(c_int)(a)
  r=f()
  return r

def BR_GetMouseCursorContext_Take():
  a=rpr_getfp('BR_GetMouseCursorContext_Take')
  f=CFUNCTYPE(c_uint64)(a)
  r=f()
  return rpr_unpackp('MediaItem_Take*',r)

def BR_GetMouseCursorContext_Track():
  a=rpr_getfp('BR_GetMouseCursorContext_Track')
  f=CFUNCTYPE(c_uint64)(a)
  r=f()
  return rpr_unpackp('MediaTrack*',r)

def BR_GetNextGridDivision(p0):
  a=rpr_getfp('BR_GetNextGridDivision')
  f=CFUNCTYPE(c_double,c_double)(a)
  t=(c_double(p0),)
  r=f(t[0])
  return r

def BR_GetPrevGridDivision(p0):
  a=rpr_getfp('BR_GetPrevGridDivision')
  f=CFUNCTYPE(c_double,c_double)(a)
  t=(c_double(p0),)
  r=f(t[0])
  return r

def BR_GetSetTrackSendInfo(p0,p1,p2,p3,p4,p5):
  a=rpr_getfp('BR_GetSetTrackSendInfo')
  f=CFUNCTYPE(c_double,c_uint64,c_int,c_int,c_char_p,c_byte,c_double)(a)
  t=(rpr_packp('MediaTrack*',p0),c_int(p1),c_int(p2),rpr_packsc(p3),c_byte(p4),c_double(p5))
  r=f(t[0],t[1],t[2],t[3],t[4],t[5])
  return r

def BR_GetTakeFXCount(p0):
  a=rpr_getfp('BR_GetTakeFXCount')
  f=CFUNCTYPE(c_int,c_uint64)(a)
  t=(rpr_packp('MediaItem_Take*',p0),)
  r=f(t[0])
  return r

def BR_IsMidiOpenInInlineEditor(p0):
  a=rpr_getfp('BR_IsMidiOpenInInlineEditor')
  f=CFUNCTYPE(c_byte,c_uint64)(a)
  t=(rpr_packp('MediaItem_Take*',p0),)
  r=f(t[0])
  return r

def BR_IsTakeMidi(p0,p1):
  a=rpr_getfp('BR_IsTakeMidi')
  f=CFUNCTYPE(c_byte,c_uint64,c_void_p)(a)
  t=(rpr_packp('MediaItem_Take*',p0),c_byte(p1))
  r=f(t[0],byref(t[1]))
  return (r,p0,int(t[1].value))

def BR_ItemAtMouseCursor(p0):
  a=rpr_getfp('BR_ItemAtMouseCursor')
  f=CFUNCTYPE(c_uint64,c_void_p)(a)
  t=(c_double(p0),)
  r=f(byref(t[0]))
  return (rpr_unpackp('MediaItem*',r),float(t[0].value))

def BR_MIDI_CCLaneRemove(p0,p1):
  a=rpr_getfp('BR_MIDI_CCLaneRemove')
  f=CFUNCTYPE(c_byte,c_uint64,c_int)(a)
  t=(rpr_packp('void*',p0),c_int(p1))
  r=f(t[0],t[1])
  return r

def BR_MIDI_CCLaneReplace(p0,p1,p2):
  a=rpr_getfp('BR_MIDI_CCLaneReplace')
  f=CFUNCTYPE(c_byte,c_uint64,c_int,c_int)(a)
  t=(rpr_packp('void*',p0),c_int(p1),c_int(p2))
  r=f(t[0],t[1],t[2])
  return r

def BR_PositionAtMouseCursor(p0):
  a=rpr_getfp('BR_PositionAtMouseCursor')
  f=CFUNCTYPE(c_double,c_byte)(a)
  t=(c_byte(p0),)
  r=f(t[0])
  return r

def BR_SetArrangeView(p0,p1,p2):
  a=rpr_getfp('BR_SetArrangeView')
  f=CFUNCTYPE(None,c_uint64,c_double,c_double)(a)
  t=(rpr_packp('ReaProject*',p0),c_double(p1),c_double(p2))
  f(t[0],t[1],t[2])

def BR_SetItemEdges(p0,p1,p2):
  a=rpr_getfp('BR_SetItemEdges')
  f=CFUNCTYPE(c_byte,c_uint64,c_double,c_double)(a)
  t=(rpr_packp('MediaItem*',p0),c_double(p1),c_double(p2))
  r=f(t[0],t[1],t[2])
  return r

def BR_SetMediaItemImageResource(p0,p1,p2):
  a=rpr_getfp('BR_SetMediaItemImageResource')
  f=CFUNCTYPE(None,c_uint64,c_char_p,c_int)(a)
  t=(rpr_packp('MediaItem*',p0),rpr_packsc(p1),c_int(p2))
  f(t[0],t[1],t[2])

def BR_SetMediaSourceProperties(p0,p1,p2,p3,p4,p5):
  a=rpr_getfp('BR_SetMediaSourceProperties')
  f=CFUNCTYPE(c_byte,c_uint64,c_byte,c_double,c_double,c_double,c_byte)(a)
  t=(rpr_packp('MediaItem_Take*',p0),c_byte(p1),c_double(p2),c_double(p3),c_double(p4),c_byte(p5))
  r=f(t[0],t[1],t[2],t[3],t[4],t[5])
  return r

def BR_SetMediaTrackLayouts(p0,p1,p2):
  a=rpr_getfp('BR_SetMediaTrackLayouts')
  f=CFUNCTYPE(c_byte,c_uint64,c_char_p,c_char_p)(a)
  t=(rpr_packp('MediaTrack*',p0),rpr_packsc(p1),rpr_packsc(p2))
  r=f(t[0],t[1],t[2])
  return r

def BR_SetMidiTakeTempoInfo(p0,p1,p2,p3,p4):
  a=rpr_getfp('BR_SetMidiTakeTempoInfo')
  f=CFUNCTYPE(c_byte,c_uint64,c_byte,c_double,c_int,c_int)(a)
  t=(rpr_packp('MediaItem_Take*',p0),c_byte(p1),c_double(p2),c_int(p3),c_int(p4))
  r=f(t[0],t[1],t[2],t[3],t[4])
  return r

def BR_SetTakeSourceFromFile(p0,p1,p2):
  a=rpr_getfp('BR_SetTakeSourceFromFile')
  f=CFUNCTYPE(c_byte,c_uint64,c_char_p,c_byte)(a)
  t=(rpr_packp('MediaItem_Take*',p0),rpr_packsc(p1),c_byte(p2))
  r=f(t[0],t[1],t[2])
  return r

def BR_SetTakeSourceFromFile2(p0,p1,p2,p3):
  a=rpr_getfp('BR_SetTakeSourceFromFile2')
  f=CFUNCTYPE(c_byte,c_uint64,c_char_p,c_byte,c_byte)(a)
  t=(rpr_packp('MediaItem_Take*',p0),rpr_packsc(p1),c_byte(p2),c_byte(p3))
  r=f(t[0],t[1],t[2],t[3])
  return r

def BR_TakeAtMouseCursor(p0):
  a=rpr_getfp('BR_TakeAtMouseCursor')
  f=CFUNCTYPE(c_uint64,c_void_p)(a)
  t=(c_double(p0),)
  r=f(byref(t[0]))
  return (rpr_unpackp('MediaItem_Take*',r),float(t[0].value))

def BR_TrackAtMouseCursor(p0,p1):
  a=rpr_getfp('BR_TrackAtMouseCursor')
  f=CFUNCTYPE(c_uint64,c_void_p,c_void_p)(a)
  t=(c_int(p0),c_double(p1))
  r=f(byref(t[0]),byref(t[1]))
  return (rpr_unpackp('MediaTrack*',r),int(t[0].value),float(t[1].value))

def BR_TrackFX_GetFXModuleName(p0,p1,p2,p3):
  a=rpr_getfp('BR_TrackFX_GetFXModuleName')
  f=CFUNCTYPE(c_byte,c_uint64,c_int,c_char_p,c_int)(a)
  t=(rpr_packp('MediaTrack*',p0),c_int(p1),rpr_packs(p2),c_int(p3))
  r=f(t[0],t[1],t[2],t[3])
  return (r,p0,p1,rpr_unpacks(t[2]),p3)

def BR_Win32_CB_FindString(p0,p1,p2):
  a=rpr_getfp('BR_Win32_CB_FindString')
  f=CFUNCTYPE(c_int,c_uint64,c_int,c_char_p)(a)
  t=(rpr_packp('void*',p0),c_int(p1),rpr_packsc(p2))
  r=f(t[0],t[1],t[2])
  return r

def BR_Win32_CB_FindStringExact(p0,p1,p2):
  a=rpr_getfp('BR_Win32_CB_FindStringExact')
  f=CFUNCTYPE(c_int,c_uint64,c_int,c_char_p)(a)
  t=(rpr_packp('void*',p0),c_int(p1),rpr_packsc(p2))
  r=f(t[0],t[1],t[2])
  return r

def BR_Win32_ClientToScreen(p0,p1,p2,p3,p4):
  a=rpr_getfp('BR_Win32_ClientToScreen')
  f=CFUNCTYPE(None,c_uint64,c_int,c_int,c_void_p,c_void_p)(a)
  t=(rpr_packp('void*',p0),c_int(p1),c_int(p2),c_int(p3),c_int(p4))
  f(t[0],t[1],t[2],byref(t[3]),byref(t[4]))
  return (p0,p1,p2,int(t[3].value),int(t[4].value))

def BR_Win32_FindWindowEx(p0,p1,p2,p3,p4,p5):
  a=rpr_getfp('BR_Win32_FindWindowEx')
  f=CFUNCTYPE(c_uint64,c_char_p,c_char_p,c_char_p,c_char_p,c_byte,c_byte)(a)
  t=(rpr_packsc(p0),rpr_packsc(p1),rpr_packsc(p2),rpr_packsc(p3),c_byte(p4),c_byte(p5))
  r=f(t[0],t[1],t[2],t[3],t[4],t[5])
  return rpr_unpackp('void*',r)

def BR_Win32_GET_X_LPARAM(p0):
  a=rpr_getfp('BR_Win32_GET_X_LPARAM')
  f=CFUNCTYPE(c_int,c_int)(a)
  t=(c_int(p0),)
  r=f(t[0])
  return r

def BR_Win32_GET_Y_LPARAM(p0):
  a=rpr_getfp('BR_Win32_GET_Y_LPARAM')
  f=CFUNCTYPE(c_int,c_int)(a)
  t=(c_int(p0),)
  r=f(t[0])
  return r

def BR_Win32_GetConstant(p0):
  a=rpr_getfp('BR_Win32_GetConstant')
  f=CFUNCTYPE(c_int,c_char_p)(a)
  t=(rpr_packsc(p0),)
  r=f(t[0])
  return r

def BR_Win32_GetCursorPos(p0,p1):
  a=rpr_getfp('BR_Win32_GetCursorPos')
  f=CFUNCTYPE(c_byte,c_void_p,c_void_p)(a)
  t=(c_int(p0),c_int(p1))
  r=f(byref(t[0]),byref(t[1]))
  return (r,int(t[0].value),int(t[1].value))

def BR_Win32_GetFocus():
  a=rpr_getfp('BR_Win32_GetFocus')
  f=CFUNCTYPE(c_uint64)(a)
  r=f()
  return rpr_unpackp('void*',r)

def BR_Win32_GetForegroundWindow():
  a=rpr_getfp('BR_Win32_GetForegroundWindow')
  f=CFUNCTYPE(c_uint64)(a)
  r=f()
  return rpr_unpackp('void*',r)

def BR_Win32_GetMainHwnd():
  a=rpr_getfp('BR_Win32_GetMainHwnd')
  f=CFUNCTYPE(c_uint64)(a)
  r=f()
  return rpr_unpackp('void*',r)

def BR_Win32_GetMixerHwnd(p0):
  a=rpr_getfp('BR_Win32_GetMixerHwnd')
  f=CFUNCTYPE(c_uint64,c_void_p)(a)
  t=(c_byte(p0),)
  r=f(byref(t[0]))
  return (rpr_unpackp('void*',r),int(t[0].value))

def BR_Win32_GetMonitorRectFromRect(p0,p1,p2,p3,p4,p5,p6,p7,p8):
  a=rpr_getfp('BR_Win32_GetMonitorRectFromRect')
  f=CFUNCTYPE(None,c_byte,c_int,c_int,c_int,c_int,c_void_p,c_void_p,c_void_p,c_void_p)(a)
  t=(c_byte(p0),c_int(p1),c_int(p2),c_int(p3),c_int(p4),c_int(p5),c_int(p6),c_int(p7),c_int(p8))
  f(t[0],t[1],t[2],t[3],t[4],byref(t[5]),byref(t[6]),byref(t[7]),byref(t[8]))
  return (p0,p1,p2,p3,p4,int(t[5].value),int(t[6].value),int(t[7].value),int(t[8].value))

def BR_Win32_GetParent(p0):
  a=rpr_getfp('BR_Win32_GetParent')
  f=CFUNCTYPE(c_uint64,c_uint64)(a)
  t=(rpr_packp('void*',p0),)
  r=f(t[0])
  return rpr_unpackp('void*',r)

def BR_Win32_GetPrivateProfileString(p0,p1,p2,p3,p4,p5):
  a=rpr_getfp('BR_Win32_GetPrivateProfileString')
  f=CFUNCTYPE(c_int,c_char_p,c_char_p,c_char_p,c_char_p,c_char_p,c_int)(a)
  t=(rpr_packsc(p0),rpr_packsc(p1),rpr_packsc(p2),rpr_packsc(p3),rpr_packs(p4),c_int(p5))
  r=f(t[0],t[1],t[2],t[3],t[4],t[5])
  return (r,p0,p1,p2,p3,rpr_unpacks(t[4]),p5)

def BR_Win32_GetWindow(p0,p1):
  a=rpr_getfp('BR_Win32_GetWindow')
  f=CFUNCTYPE(c_uint64,c_uint64,c_int)(a)
  t=(rpr_packp('void*',p0),c_int(p1))
  r=f(t[0],t[1])
  return rpr_unpackp('void*',r)

def BR_Win32_GetWindowLong(p0,p1):
  a=rpr_getfp('BR_Win32_GetWindowLong')
  f=CFUNCTYPE(c_int,c_uint64,c_int)(a)
  t=(rpr_packp('void*',p0),c_int(p1))
  r=f(t[0],t[1])
  return r

def BR_Win32_GetWindowRect(p0,p1,p2,p3,p4):
  a=rpr_getfp('BR_Win32_GetWindowRect')
  f=CFUNCTYPE(c_byte,c_uint64,c_void_p,c_void_p,c_void_p,c_void_p)(a)
  t=(rpr_packp('void*',p0),c_int(p1),c_int(p2),c_int(p3),c_int(p4))
  r=f(t[0],byref(t[1]),byref(t[2]),byref(t[3]),byref(t[4]))
  return (r,p0,int(t[1].value),int(t[2].value),int(t[3].value),int(t[4].value))

def BR_Win32_GetWindowText(p0,p1,p2):
  a=rpr_getfp('BR_Win32_GetWindowText')
  f=CFUNCTYPE(c_int,c_uint64,c_char_p,c_int)(a)
  t=(rpr_packp('void*',p0),rpr_packs(p1),c_int(p2))
  r=f(t[0],t[1],t[2])
  return (r,p0,rpr_unpacks(t[1]),p2)

def BR_Win32_HIBYTE(p0):
  a=rpr_getfp('BR_Win32_HIBYTE')
  f=CFUNCTYPE(c_int,c_int)(a)
  t=(c_int(p0),)
  r=f(t[0])
  return r

def BR_Win32_HIWORD(p0):
  a=rpr_getfp('BR_Win32_HIWORD')
  f=CFUNCTYPE(c_int,c_int)(a)
  t=(c_int(p0),)
  r=f(t[0])
  return r

def BR_Win32_HwndToString(p0,p1,p2):
  a=rpr_getfp('BR_Win32_HwndToString')
  f=CFUNCTYPE(None,c_uint64,c_char_p,c_int)(a)
  t=(rpr_packp('void*',p0),rpr_packs(p1),c_int(p2))
  f(t[0],t[1],t[2])
  return (p0,rpr_unpacks(t[1]),p2)

def BR_Win32_IsWindow(p0):
  a=rpr_getfp('BR_Win32_IsWindow')
  f=CFUNCTYPE(c_byte,c_uint64)(a)
  t=(rpr_packp('void*',p0),)
  r=f(t[0])
  return r

def BR_Win32_IsWindowVisible(p0):
  a=rpr_getfp('BR_Win32_IsWindowVisible')
  f=CFUNCTYPE(c_byte,c_uint64)(a)
  t=(rpr_packp('void*',p0),)
  r=f(t[0])
  return r

def BR_Win32_LOBYTE(p0):
  a=rpr_getfp('BR_Win32_LOBYTE')
  f=CFUNCTYPE(c_int,c_int)(a)
  t=(c_int(p0),)
  r=f(t[0])
  return r

def BR_Win32_LOWORD(p0):
  a=rpr_getfp('BR_Win32_LOWORD')
  f=CFUNCTYPE(c_int,c_int)(a)
  t=(c_int(p0),)
  r=f(t[0])
  return r

def BR_Win32_MAKELONG(p0,p1):
  a=rpr_getfp('BR_Win32_MAKELONG')
  f=CFUNCTYPE(c_int,c_int,c_int)(a)
  t=(c_int(p0),c_int(p1))
  r=f(t[0],t[1])
  return r

def BR_Win32_MAKELPARAM(p0,p1):
  a=rpr_getfp('BR_Win32_MAKELPARAM')
  f=CFUNCTYPE(c_int,c_int,c_int)(a)
  t=(c_int(p0),c_int(p1))
  r=f(t[0],t[1])
  return r

def BR_Win32_MAKELRESULT(p0,p1):
  a=rpr_getfp('BR_Win32_MAKELRESULT')
  f=CFUNCTYPE(c_int,c_int,c_int)(a)
  t=(c_int(p0),c_int(p1))
  r=f(t[0],t[1])
  return r

def BR_Win32_MAKEWORD(p0,p1):
  a=rpr_getfp('BR_Win32_MAKEWORD')
  f=CFUNCTYPE(c_int,c_int,c_int)(a)
  t=(c_int(p0),c_int(p1))
  r=f(t[0],t[1])
  return r

def BR_Win32_MAKEWPARAM(p0,p1):
  a=rpr_getfp('BR_Win32_MAKEWPARAM')
  f=CFUNCTYPE(c_int,c_int,c_int)(a)
  t=(c_int(p0),c_int(p1))
  r=f(t[0],t[1])
  return r

def BR_Win32_MIDIEditor_GetActive():
  a=rpr_getfp('BR_Win32_MIDIEditor_GetActive')
  f=CFUNCTYPE(c_uint64)(a)
  r=f()
  return rpr_unpackp('void*',r)

def BR_Win32_ScreenToClient(p0,p1,p2,p3,p4):
  a=rpr_getfp('BR_Win32_ScreenToClient')
  f=CFUNCTYPE(None,c_uint64,c_int,c_int,c_void_p,c_void_p)(a)
  t=(rpr_packp('void*',p0),c_int(p1),c_int(p2),c_int(p3),c_int(p4))
  f(t[0],t[1],t[2],byref(t[3]),byref(t[4]))
  return (p0,p1,p2,int(t[3].value),int(t[4].value))

def BR_Win32_SendMessage(p0,p1,p2,p3):
  a=rpr_getfp('BR_Win32_SendMessage')
  f=CFUNCTYPE(c_int,c_uint64,c_int,c_int,c_int)(a)
  t=(rpr_packp('void*',p0),c_int(p1),c_int(p2),c_int(p3))
  r=f(t[0],t[1],t[2],t[3])
  return r

def BR_Win32_SetFocus(p0):
  a=rpr_getfp('BR_Win32_SetFocus')
  f=CFUNCTYPE(c_uint64,c_uint64)(a)
  t=(rpr_packp('void*',p0),)
  r=f(t[0])
  return rpr_unpackp('void*',r)

def BR_Win32_SetForegroundWindow(p0):
  a=rpr_getfp('BR_Win32_SetForegroundWindow')
  f=CFUNCTYPE(c_int,c_uint64)(a)
  t=(rpr_packp('void*',p0),)
  r=f(t[0])
  return r

def BR_Win32_SetWindowLong(p0,p1,p2):
  a=rpr_getfp('BR_Win32_SetWindowLong')
  f=CFUNCTYPE(c_int,c_uint64,c_int,c_int)(a)
  t=(rpr_packp('void*',p0),c_int(p1),c_int(p2))
  r=f(t[0],t[1],t[2])
  return r

def BR_Win32_SetWindowPos(p0,p1,p2,p3,p4,p5,p6):
  a=rpr_getfp('BR_Win32_SetWindowPos')
  f=CFUNCTYPE(c_byte,c_uint64,c_char_p,c_int,c_int,c_int,c_int,c_int)(a)
  t=(rpr_packp('void*',p0),rpr_packsc(p1),c_int(p2),c_int(p3),c_int(p4),c_int(p5),c_int(p6))
  r=f(t[0],t[1],t[2],t[3],t[4],t[5],t[6])
  return r

def BR_Win32_ShellExecute(p0,p1,p2,p3,p4):
  a=rpr_getfp('BR_Win32_ShellExecute')
  f=CFUNCTYPE(c_int,c_char_p,c_char_p,c_char_p,c_char_p,c_int)(a)
  t=(rpr_packsc(p0),rpr_packsc(p1),rpr_packsc(p2),rpr_packsc(p3),c_int(p4))
  r=f(t[0],t[1],t[2],t[3],t[4])
  return r

def BR_Win32_ShowWindow(p0,p1):
  a=rpr_getfp('BR_Win32_ShowWindow')
  f=CFUNCTYPE(c_byte,c_uint64,c_int)(a)
  t=(rpr_packp('void*',p0),c_int(p1))
  r=f(t[0],t[1])
  return r

def BR_Win32_StringToHwnd(p0):
  a=rpr_getfp('BR_Win32_StringToHwnd')
  f=CFUNCTYPE(c_uint64,c_char_p)(a)
  t=(rpr_packsc(p0),)
  r=f(t[0])
  return rpr_unpackp('void*',r)

def BR_Win32_WindowFromPoint(p0,p1):
  a=rpr_getfp('BR_Win32_WindowFromPoint')
  f=CFUNCTYPE(c_uint64,c_int,c_int)(a)
  t=(c_int(p0),c_int(p1))
  r=f(t[0],t[1])
  return rpr_unpackp('void*',r)

def BR_Win32_WritePrivateProfileString(p0,p1,p2,p3):
  a=rpr_getfp('BR_Win32_WritePrivateProfileString')
  f=CFUNCTYPE(c_byte,c_char_p,c_char_p,c_char_p,c_char_p)(a)
  t=(rpr_packsc(p0),rpr_packsc(p1),rpr_packsc(p2),rpr_packsc(p3))
  r=f(t[0],t[1],t[2],t[3])
  return r

def CF_EnumerateActions(p0,p1,p2,p3):
  a=rpr_getfp('CF_EnumerateActions')
  f=CFUNCTYPE(c_int,c_int,c_int,c_char_p,c_int)(a)
  t=(c_int(p0),c_int(p1),rpr_packs(p2),c_int(p3))
  r=f(t[0],t[1],t[2],t[3])
  return (r,p0,p1,rpr_unpacks(t[2]),p3)

def CF_EnumMediaSourceCues(p0,p1,p2,p3,p4,p5,p6):
  a=rpr_getfp('CF_EnumMediaSourceCues')
  f=CFUNCTYPE(c_int,c_uint64,c_int,c_void_p,c_void_p,c_void_p,c_char_p,c_int)(a)
  t=(rpr_packp('PCM_source*',p0),c_int(p1),c_double(p2),c_double(p3),c_byte(p4),rpr_packs(p5),c_int(p6))
  r=f(t[0],t[1],byref(t[2]),byref(t[3]),byref(t[4]),t[5],t[6])
  return (r,p0,p1,float(t[2].value),float(t[3].value),int(t[4].value),rpr_unpacks(t[5]),p6)

def CF_EnumSelectedFX(p0,p1):
  a=rpr_getfp('CF_EnumSelectedFX')
  f=CFUNCTYPE(c_int,c_uint64,c_int)(a)
  t=(rpr_packp('FxChain*',p0),c_int(p1))
  r=f(t[0],t[1])
  return r

def CF_ExportMediaSource(p0,p1):
  a=rpr_getfp('CF_ExportMediaSource')
  f=CFUNCTYPE(c_byte,c_uint64,c_char_p)(a)
  t=(rpr_packp('PCM_source*',p0),rpr_packsc(p1))
  r=f(t[0],t[1])
  return r

def CF_GetClipboard(p0,p1):
  a=rpr_getfp('CF_GetClipboard')
  f=CFUNCTYPE(None,c_char_p,c_int)(a)
  t=(rpr_packs(p0),c_int(p1))
  f(t[0],t[1])
  return (rpr_unpacks(t[0]),p1)

def CF_GetClipboardBig(p0):
  a=rpr_getfp('CF_GetClipboardBig')
  f=CFUNCTYPE(c_char_p,c_uint64)(a)
  t=(rpr_packp('WDL_FastString*',p0),)
  r=f(t[0])
  return str(r.decode())

def CF_GetCommandText(p0,p1):
  a=rpr_getfp('CF_GetCommandText')
  f=CFUNCTYPE(c_char_p,c_int,c_int)(a)
  t=(c_int(p0),c_int(p1))
  r=f(t[0],t[1])
  return str(r.decode())

def CF_GetFocusedFXChain():
  a=rpr_getfp('CF_GetFocusedFXChain')
  f=CFUNCTYPE(c_uint64)(a)
  r=f()
  return rpr_unpackp('FxChain*',r)

def CF_GetMediaSourceBitDepth(p0):
  a=rpr_getfp('CF_GetMediaSourceBitDepth')
  f=CFUNCTYPE(c_int,c_uint64)(a)
  t=(rpr_packp('PCM_source*',p0),)
  r=f(t[0])
  return r

def CF_GetMediaSourceMetadata(p0,p1,p2,p3):
  a=rpr_getfp('CF_GetMediaSourceMetadata')
  f=CFUNCTYPE(c_byte,c_uint64,c_char_p,c_char_p,c_int)(a)
  t=(rpr_packp('PCM_source*',p0),rpr_packsc(p1),rpr_packs(p2),c_int(p3))
  r=f(t[0],t[1],t[2],t[3])
  return (r,p0,p1,rpr_unpacks(t[2]),p3)

def CF_GetMediaSourceOnline(p0):
  a=rpr_getfp('CF_GetMediaSourceOnline')
  f=CFUNCTYPE(c_byte,c_uint64)(a)
  t=(rpr_packp('PCM_source*',p0),)
  r=f(t[0])
  return r

def CF_GetMediaSourceRPP(p0,p1,p2):
  a=rpr_getfp('CF_GetMediaSourceRPP')
  f=CFUNCTYPE(c_byte,c_uint64,c_char_p,c_int)(a)
  t=(rpr_packp('PCM_source*',p0),rpr_packs(p1),c_int(p2))
  r=f(t[0],t[1],t[2])
  return (r,p0,rpr_unpacks(t[1]),p2)

def CF_GetSWSVersion(p0,p1):
  a=rpr_getfp('CF_GetSWSVersion')
  f=CFUNCTYPE(None,c_char_p,c_int)(a)
  t=(rpr_packs(p0),c_int(p1))
  f(t[0],t[1])
  return (rpr_unpacks(t[0]),p1)

def CF_GetTakeFXChain(p0):
  a=rpr_getfp('CF_GetTakeFXChain')
  f=CFUNCTYPE(c_uint64,c_uint64)(a)
  t=(rpr_packp('MediaItem_Take*',p0),)
  r=f(t[0])
  return rpr_unpackp('FxChain*',r)

def CF_GetTrackFXChain(p0):
  a=rpr_getfp('CF_GetTrackFXChain')
  f=CFUNCTYPE(c_uint64,c_uint64)(a)
  t=(rpr_packp('MediaTrack*',p0),)
  r=f(t[0])
  return rpr_unpackp('FxChain*',r)

def CF_LocateInExplorer(p0):
  a=rpr_getfp('CF_LocateInExplorer')
  f=CFUNCTYPE(c_byte,c_char_p)(a)
  t=(rpr_packsc(p0),)
  r=f(t[0])
  return r

def CF_SetClipboard(p0):
  a=rpr_getfp('CF_SetClipboard')
  f=CFUNCTYPE(None,c_char_p)(a)
  t=(rpr_packsc(p0),)
  f(t[0])

def CF_SetMediaSourceOnline(p0,p1):
  a=rpr_getfp('CF_SetMediaSourceOnline')
  f=CFUNCTYPE(None,c_uint64,c_byte)(a)
  t=(rpr_packp('PCM_source*',p0),c_byte(p1))
  f(t[0],t[1])

def CF_ShellExecute(p0):
  a=rpr_getfp('CF_ShellExecute')
  f=CFUNCTYPE(c_byte,c_char_p)(a)
  t=(rpr_packsc(p0),)
  r=f(t[0])
  return r

def FNG_AddMidiNote(p0):
  a=rpr_getfp('FNG_AddMidiNote')
  f=CFUNCTYPE(c_uint64,c_uint64)(a)
  t=(rpr_packp('RprMidiTake*',p0),)
  r=f(t[0])
  return rpr_unpackp('RprMidiNote*',r)

def FNG_AllocMidiTake(p0):
  a=rpr_getfp('FNG_AllocMidiTake')
  f=CFUNCTYPE(c_uint64,c_uint64)(a)
  t=(rpr_packp('MediaItem_Take*',p0),)
  r=f(t[0])
  return rpr_unpackp('RprMidiTake*',r)

def FNG_CountMidiNotes(p0):
  a=rpr_getfp('FNG_CountMidiNotes')
  f=CFUNCTYPE(c_int,c_uint64)(a)
  t=(rpr_packp('RprMidiTake*',p0),)
  r=f(t[0])
  return r

def FNG_FreeMidiTake(p0):
  a=rpr_getfp('FNG_FreeMidiTake')
  f=CFUNCTYPE(None,c_uint64)(a)
  t=(rpr_packp('RprMidiTake*',p0),)
  f(t[0])

def FNG_GetMidiNote(p0,p1):
  a=rpr_getfp('FNG_GetMidiNote')
  f=CFUNCTYPE(c_uint64,c_uint64,c_int)(a)
  t=(rpr_packp('RprMidiTake*',p0),c_int(p1))
  r=f(t[0],t[1])
  return rpr_unpackp('RprMidiNote*',r)

def FNG_GetMidiNoteIntProperty(p0,p1):
  a=rpr_getfp('FNG_GetMidiNoteIntProperty')
  f=CFUNCTYPE(c_int,c_uint64,c_char_p)(a)
  t=(rpr_packp('RprMidiNote*',p0),rpr_packsc(p1))
  r=f(t[0],t[1])
  return r

def FNG_SetMidiNoteIntProperty(p0,p1,p2):
  a=rpr_getfp('FNG_SetMidiNoteIntProperty')
  f=CFUNCTYPE(None,c_uint64,c_char_p,c_int)(a)
  t=(rpr_packp('RprMidiNote*',p0),rpr_packsc(p1),c_int(p2))
  f(t[0],t[1],t[2])

def NF_AnalyzeMediaItemPeakAndRMS(p0,p1,p2,p3,p4,p5):
  a=rpr_getfp('NF_AnalyzeMediaItemPeakAndRMS')
  f=CFUNCTYPE(c_byte,c_uint64,c_double,c_uint64,c_uint64,c_uint64,c_uint64)(a)
  t=(rpr_packp('MediaItem*',p0),c_double(p1),rpr_packp('void*',p2),rpr_packp('void*',p3),rpr_packp('void*',p4),rpr_packp('void*',p5))
  r=f(t[0],t[1],t[2],t[3],t[4],t[5])
  return r

def NF_AnalyzeTakeLoudness(p0,p1,p2,p3,p4,p5,p6,p7):
  a=rpr_getfp('NF_AnalyzeTakeLoudness')
  f=CFUNCTYPE(c_byte,c_uint64,c_byte,c_void_p,c_void_p,c_void_p,c_void_p,c_void_p,c_void_p)(a)
  t=(rpr_packp('MediaItem_Take*',p0),c_byte(p1),c_double(p2),c_double(p3),c_double(p4),c_double(p5),c_double(p6),c_double(p7))
  r=f(t[0],t[1],byref(t[2]),byref(t[3]),byref(t[4]),byref(t[5]),byref(t[6]),byref(t[7]))
  return (r,p0,p1,float(t[2].value),float(t[3].value),float(t[4].value),float(t[5].value),float(t[6].value),float(t[7].value))

def NF_AnalyzeTakeLoudness2(p0,p1,p2,p3,p4,p5,p6,p7,p8,p9):
  a=rpr_getfp('NF_AnalyzeTakeLoudness2')
  f=CFUNCTYPE(c_byte,c_uint64,c_byte,c_void_p,c_void_p,c_void_p,c_void_p,c_void_p,c_void_p,c_void_p,c_void_p)(a)
  t=(rpr_packp('MediaItem_Take*',p0),c_byte(p1),c_double(p2),c_double(p3),c_double(p4),c_double(p5),c_double(p6),c_double(p7),c_double(p8),c_double(p9))
  r=f(t[0],t[1],byref(t[2]),byref(t[3]),byref(t[4]),byref(t[5]),byref(t[6]),byref(t[7]),byref(t[8]),byref(t[9]))
  return (r,p0,p1,float(t[2].value),float(t[3].value),float(t[4].value),float(t[5].value),float(t[6].value),float(t[7].value),float(t[8].value),float(t[9].value))

def NF_AnalyzeTakeLoudness_IntegratedOnly(p0,p1):
  a=rpr_getfp('NF_AnalyzeTakeLoudness_IntegratedOnly')
  f=CFUNCTYPE(c_byte,c_uint64,c_void_p)(a)
  t=(rpr_packp('MediaItem_Take*',p0),c_double(p1))
  r=f(t[0],byref(t[1]))
  return (r,p0,float(t[1].value))

def NF_GetMediaItemAverageRMS(p0):
  a=rpr_getfp('NF_GetMediaItemAverageRMS')
  f=CFUNCTYPE(c_double,c_uint64)(a)
  t=(rpr_packp('MediaItem*',p0),)
  r=f(t[0])
  return r

def NF_GetMediaItemMaxPeak(p0):
  a=rpr_getfp('NF_GetMediaItemMaxPeak')
  f=CFUNCTYPE(c_double,c_uint64)(a)
  t=(rpr_packp('MediaItem*',p0),)
  r=f(t[0])
  return r

def NF_GetMediaItemMaxPeakAndMaxPeakPos(p0,p1):
  a=rpr_getfp('NF_GetMediaItemMaxPeakAndMaxPeakPos')
  f=CFUNCTYPE(c_double,c_uint64,c_void_p)(a)
  t=(rpr_packp('MediaItem*',p0),c_double(p1))
  r=f(t[0],byref(t[1]))
  return (r,p0,float(t[1].value))

def NF_GetMediaItemPeakRMS_NonWindowed(p0):
  a=rpr_getfp('NF_GetMediaItemPeakRMS_NonWindowed')
  f=CFUNCTYPE(c_double,c_uint64)(a)
  t=(rpr_packp('MediaItem*',p0),)
  r=f(t[0])
  return r

def NF_GetMediaItemPeakRMS_Windowed(p0):
  a=rpr_getfp('NF_GetMediaItemPeakRMS_Windowed')
  f=CFUNCTYPE(c_double,c_uint64)(a)
  t=(rpr_packp('MediaItem*',p0),)
  r=f(t[0])
  return r

def NF_GetSWSMarkerRegionSub(p0):
  a=rpr_getfp('NF_GetSWSMarkerRegionSub')
  f=CFUNCTYPE(c_char_p,c_int)(a)
  t=(c_int(p0),)
  r=f(t[0])
  return str(r.decode())

def NF_GetSWSTrackNotes(p0):
  a=rpr_getfp('NF_GetSWSTrackNotes')
  f=CFUNCTYPE(c_char_p,c_uint64)(a)
  t=(rpr_packp('MediaTrack*',p0),)
  r=f(t[0])
  return str(r.decode())

def NF_SetSWSMarkerRegionSub(p0,p1):
  a=rpr_getfp('NF_SetSWSMarkerRegionSub')
  f=CFUNCTYPE(c_byte,c_char_p,c_int)(a)
  t=(rpr_packsc(p0),c_int(p1))
  r=f(t[0],t[1])
  return r

def NF_SetSWSTrackNotes(p0,p1):
  a=rpr_getfp('NF_SetSWSTrackNotes')
  f=CFUNCTYPE(None,c_uint64,c_char_p)(a)
  t=(rpr_packp('MediaTrack*',p0),rpr_packsc(p1))
  f(t[0],t[1])

def NF_UpdateSWSMarkerRegionSubWindow():
  a=rpr_getfp('NF_UpdateSWSMarkerRegionSubWindow')
  f=CFUNCTYPE(None)(a)
  f()

def SN_FocusMIDIEditor():
  a=rpr_getfp('SN_FocusMIDIEditor')
  f=CFUNCTYPE(None)(a)
  f()

def SNM_AddReceive(p0,p1,p2):
  a=rpr_getfp('SNM_AddReceive')
  f=CFUNCTYPE(c_byte,c_uint64,c_uint64,c_int)(a)
  t=(rpr_packp('MediaTrack*',p0),rpr_packp('MediaTrack*',p1),c_int(p2))
  r=f(t[0],t[1],t[2])
  return r

def SNM_AddTCPFXParm(p0,p1,p2):
  a=rpr_getfp('SNM_AddTCPFXParm')
  f=CFUNCTYPE(c_byte,c_uint64,c_int,c_int)(a)
  t=(rpr_packp('MediaTrack*',p0),c_int(p1),c_int(p2))
  r=f(t[0],t[1],t[2])
  return r

def SNM_CreateFastString(p0):
  a=rpr_getfp('SNM_CreateFastString')
  f=CFUNCTYPE(c_uint64,c_char_p)(a)
  t=(rpr_packsc(p0),)
  r=f(t[0])
  return rpr_unpackp('WDL_FastString*',r)

def SNM_DeleteFastString(p0):
  a=rpr_getfp('SNM_DeleteFastString')
  f=CFUNCTYPE(None,c_uint64)(a)
  t=(rpr_packp('WDL_FastString*',p0),)
  f(t[0])

def SNM_GetDoubleConfigVar(p0,p1):
  a=rpr_getfp('SNM_GetDoubleConfigVar')
  f=CFUNCTYPE(c_double,c_char_p,c_double)(a)
  t=(rpr_packsc(p0),c_double(p1))
  r=f(t[0],t[1])
  return r

def SNM_GetFastString(p0):
  a=rpr_getfp('SNM_GetFastString')
  f=CFUNCTYPE(c_char_p,c_uint64)(a)
  t=(rpr_packp('WDL_FastString*',p0),)
  r=f(t[0])
  return str(r.decode())

def SNM_GetFastStringLength(p0):
  a=rpr_getfp('SNM_GetFastStringLength')
  f=CFUNCTYPE(c_int,c_uint64)(a)
  t=(rpr_packp('WDL_FastString*',p0),)
  r=f(t[0])
  return r

def SNM_GetIntConfigVar(p0,p1):
  a=rpr_getfp('SNM_GetIntConfigVar')
  f=CFUNCTYPE(c_int,c_char_p,c_int)(a)
  t=(rpr_packsc(p0),c_int(p1))
  r=f(t[0],t[1])
  return r

def SNM_GetMediaItemTakeByGUID(p0,p1):
  a=rpr_getfp('SNM_GetMediaItemTakeByGUID')
  f=CFUNCTYPE(c_uint64,c_uint64,c_char_p)(a)
  t=(rpr_packp('ReaProject*',p0),rpr_packsc(p1))
  r=f(t[0],t[1])
  return rpr_unpackp('MediaItem_Take*',r)

def SNM_GetProjectMarkerName(p0,p1,p2,p3):
  a=rpr_getfp('SNM_GetProjectMarkerName')
  f=CFUNCTYPE(c_byte,c_uint64,c_int,c_byte,c_uint64)(a)
  t=(rpr_packp('ReaProject*',p0),c_int(p1),c_byte(p2),rpr_packp('WDL_FastString*',p3))
  r=f(t[0],t[1],t[2],t[3])
  return r

def SNM_GetSetObjectState(p0,p1,p2,p3):
  a=rpr_getfp('SNM_GetSetObjectState')
  f=CFUNCTYPE(c_byte,c_uint64,c_uint64,c_byte,c_byte)(a)
  t=(rpr_packp('void*',p0),rpr_packp('WDL_FastString*',p1),c_byte(p2),c_byte(p3))
  r=f(t[0],t[1],t[2],t[3])
  return r

def SNM_GetSetSourceState(p0,p1,p2,p3):
  a=rpr_getfp('SNM_GetSetSourceState')
  f=CFUNCTYPE(c_byte,c_uint64,c_int,c_uint64,c_byte)(a)
  t=(rpr_packp('MediaItem*',p0),c_int(p1),rpr_packp('WDL_FastString*',p2),c_byte(p3))
  r=f(t[0],t[1],t[2],t[3])
  return r

def SNM_GetSetSourceState2(p0,p1,p2):
  a=rpr_getfp('SNM_GetSetSourceState2')
  f=CFUNCTYPE(c_byte,c_uint64,c_uint64,c_byte)(a)
  t=(rpr_packp('MediaItem_Take*',p0),rpr_packp('WDL_FastString*',p1),c_byte(p2))
  r=f(t[0],t[1],t[2])
  return r

def SNM_GetSourceType(p0,p1):
  a=rpr_getfp('SNM_GetSourceType')
  f=CFUNCTYPE(c_byte,c_uint64,c_uint64)(a)
  t=(rpr_packp('MediaItem_Take*',p0),rpr_packp('WDL_FastString*',p1))
  r=f(t[0],t[1])
  return r

def SNM_MoveOrRemoveTrackFX(p0,p1,p2):
  a=rpr_getfp('SNM_MoveOrRemoveTrackFX')
  f=CFUNCTYPE(c_byte,c_uint64,c_int,c_int)(a)
  t=(rpr_packp('MediaTrack*',p0),c_int(p1),c_int(p2))
  r=f(t[0],t[1],t[2])
  return r

def SNM_ReadMediaFileTag(p0,p1,p2,p3):
  a=rpr_getfp('SNM_ReadMediaFileTag')
  f=CFUNCTYPE(c_byte,c_char_p,c_char_p,c_char_p,c_int)(a)
  t=(rpr_packsc(p0),rpr_packsc(p1),rpr_packs(p2),c_int(p3))
  r=f(t[0],t[1],t[2],t[3])
  return (r,p0,p1,rpr_unpacks(t[2]),p3)

def SNM_RemoveReceive(p0,p1):
  a=rpr_getfp('SNM_RemoveReceive')
  f=CFUNCTYPE(c_byte,c_uint64,c_int)(a)
  t=(rpr_packp('MediaTrack*',p0),c_int(p1))
  r=f(t[0],t[1])
  return r

def SNM_RemoveReceivesFrom(p0,p1):
  a=rpr_getfp('SNM_RemoveReceivesFrom')
  f=CFUNCTYPE(c_byte,c_uint64,c_uint64)(a)
  t=(rpr_packp('MediaTrack*',p0),rpr_packp('MediaTrack*',p1))
  r=f(t[0],t[1])
  return r

def SNM_SelectResourceBookmark(p0):
  a=rpr_getfp('SNM_SelectResourceBookmark')
  f=CFUNCTYPE(c_int,c_char_p)(a)
  t=(rpr_packsc(p0),)
  r=f(t[0])
  return r

def SNM_SetDoubleConfigVar(p0,p1):
  a=rpr_getfp('SNM_SetDoubleConfigVar')
  f=CFUNCTYPE(c_byte,c_char_p,c_double)(a)
  t=(rpr_packsc(p0),c_double(p1))
  r=f(t[0],t[1])
  return r

def SNM_SetFastString(p0,p1):
  a=rpr_getfp('SNM_SetFastString')
  f=CFUNCTYPE(c_uint64,c_uint64,c_char_p)(a)
  t=(rpr_packp('WDL_FastString*',p0),rpr_packsc(p1))
  r=f(t[0],t[1])
  return rpr_unpackp('WDL_FastString*',r)

def SNM_SetIntConfigVar(p0,p1):
  a=rpr_getfp('SNM_SetIntConfigVar')
  f=CFUNCTYPE(c_byte,c_char_p,c_int)(a)
  t=(rpr_packsc(p0),c_int(p1))
  r=f(t[0],t[1])
  return r

def SNM_SetProjectMarker(p0,p1,p2,p3,p4,p5,p6):
  a=rpr_getfp('SNM_SetProjectMarker')
  f=CFUNCTYPE(c_byte,c_uint64,c_int,c_byte,c_double,c_double,c_char_p,c_int)(a)
  t=(rpr_packp('ReaProject*',p0),c_int(p1),c_byte(p2),c_double(p3),c_double(p4),rpr_packsc(p5),c_int(p6))
  r=f(t[0],t[1],t[2],t[3],t[4],t[5],t[6])
  return r

def SNM_TagMediaFile(p0,p1,p2):
  a=rpr_getfp('SNM_TagMediaFile')
  f=CFUNCTYPE(c_byte,c_char_p,c_char_p,c_char_p)(a)
  t=(rpr_packsc(p0),rpr_packsc(p1),rpr_packsc(p2))
  r=f(t[0],t[1],t[2])
  return r

def SNM_TieResourceSlotActions(p0):
  a=rpr_getfp('SNM_TieResourceSlotActions')
  f=CFUNCTYPE(None,c_int)(a)
  t=(c_int(p0),)
  f(t[0])

def ULT_GetMediaItemNote(p0):
  a=rpr_getfp('ULT_GetMediaItemNote')
  f=CFUNCTYPE(c_char_p,c_uint64)(a)
  t=(rpr_packp('MediaItem*',p0),)
  r=f(t[0])
  return str(r.decode())

def ULT_SetMediaItemNote(p0,p1):
  a=rpr_getfp('ULT_SetMediaItemNote')
  f=CFUNCTYPE(None,c_uint64,c_char_p)(a)
  t=(rpr_packp('MediaItem*',p0),rpr_packsc(p1))
  f(t[0],t[1])

