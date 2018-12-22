jQuery ->
  new LogoCropper()

class LogoCropper
  constructor: ->
    $('#employer_cropbox').Jcrop
      aspectRatio: 1
      setSelect: [0, 0, 600, 600]
      onSelect: @update
      onChange: @update

  update: (coords) =>
    $('#employer_crop_x').val(coords.x)
    $('#employer_crop_y').val(coords.y)
    $('#employer_crop_w').val(coords.w)
    $('#employer_crop_h').val(coords.h)
    @updatePreview(coords)

  updatePreview: (coords) =>
  	$('#employer_preview').css
  		width: Math.round(100/coords.w * $('#employer_cropbox').width()) + 'px'
  		height: Math.round(100/coords.h * $('#employer_cropbox').height()) + 'px'
  		marginLeft: '-' + Math.round(100/coords.w * coords.x) + 'px'
  		marginTop: '-' + Math.round(100/coords.h * coords.y) + 'px'
