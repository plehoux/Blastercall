w = window
for vendor in ['ms', 'moz', 'webkit', 'o']
    break if w.requestAnimationFrame
    w.requestAnimationFrame = w["#{vendor}RequestAnimationFrame"]
    w.cancelAnimationFrame = (w["#{vendor}CancelAnimationFrame"] or
                              w["#{vendor}CancelRequestAnimationFrame"])

targetTime = 0
w.requestAnimationFrame or= (callback) ->
    targetTime = Math.max targetTime + 16, currentTime = +new Date
    w.setTimeout (-> callback +new Date), targetTime - currentTime

w.cancelAnimationFrame or= (id) -> clearTimeout id
