import os
import datetime
import time
from enum import Enum
"""
Logs to a .txt file
"""
class LogLevel(Enum):
    LOG = 1
    WARNING = 2
    ERROR = 3

class Logger():
    def __init__(self, save_path):
        self.save_path = save_path
        self.time0 = None
        self.epoch0 = 0
        if os.path.exists(save_path):
            os.remove(save_path)

    def timestamp(self):
        now = datetime.datetime.now()
        timestamp = "{}-{:02}-{:02} {:02}:{:02}:{:02}s".format(now.year, now.month, now.day, now.hour, now.minute, now.second)
        return timestamp

    def print(self, level: LogLevel, msg: str):
        timestamp = self.timestamp()
        print("[{}] |{}| {}".format(timestamp, level.name, msg)) # print the message 
        with open(self.save_path, "a") as log_file:
            log_file.write('[{}] |{}| {}\n'.format(timestamp, level.name, msg)) # log the message

    def format_seconds(self, sec):
        m, s = divmod(sec, 60)
        h, m = divmod(m, 60)
        return h, m, s

    def print_current_losses(self, epoch, n_epochs, losses):
        
        if self.time0 is None:
            self.time0 = time.time()
            self.epoch0 = epoch
            d_t = 0
            d_epoch = 1
        else:
            d_t = time.time() - self.time0
            d_epoch = epoch - self.epoch0

        h, m, s = self.format_seconds(d_t)
        message = '[{}] ({:02.0f}:{:02.0f}:{:02.0f}) {:.2f}s/epoch. Epoch: {} | '.format(timestamp, h, m, s, d_t/(d_epoch+1e-6), epoch)
        for k, v in losses.items():
            if k.lower() == 'total':
                continue
            message += '%s:%.7f ' % (k, v)
        self.write(message)
