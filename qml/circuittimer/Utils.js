.pragma library

function zeroPad(n)
{
    return (n < 10 ? "0" : "") + n
}

function toTime(sec)
{
    var mod = Math.abs(sec)
    return (sec < 0 ? "-" : "") +
            (mod >= 3600 ? Math.floor(mod / 3600) + ':' : '') +
            zeroPad(Math.floor((mod % 3600) / 60)) + ':' +
            zeroPad(Math.floor((mod % 60)))
}
