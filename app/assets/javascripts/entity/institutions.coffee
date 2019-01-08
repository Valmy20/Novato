jQuery ->
  new LogoCropper()

class LogoCropper
  constructor: ->
    $('#institution_cropbox').Jcrop
      aspectRatio: 1
      setSelect: [0, 0, 600, 600]
      onSelect: @update
      onChange: @update

  update: (coords) =>
    $('#institution_crop_x').val(coords.x)
    $('#institution_crop_y').val(coords.y)
    $('#institution_crop_w').val(coords.w)
    $('#institution_crop_h').val(coords.h)
    @updatePreview(coords)

  updatePreview: (coords) =>
  	$('#institution_preview').css
  		width: Math.round(100/coords.w * $('#institution_cropbox').width()) + 'px'
  		height: Math.round(100/coords.h * $('#institution_cropbox').height()) + 'px'
  		marginLeft: '-' + Math.round(100/coords.w * coords.x) + 'px'
  		marginTop: '-' + Math.round(100/coords.h * coords.y) + 'px'
