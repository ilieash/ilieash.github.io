from pushbullet import Pushbullet

pb = Pushbullet('')

push = pb.push_note("FLEXGET ERROR","Flexget gave a CRITICAL error and stopped working")
