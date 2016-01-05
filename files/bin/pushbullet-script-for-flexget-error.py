from pushbullet import Pushbullet

pb = Pushbullet('dTYbfhCycFiG25lYOBtFNzbxeMKQRwSB')

push = pb.push_note("FLEXGET ERROR","Flexget gave a CRITICAL error and stopped working")
