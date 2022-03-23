from PyQt5.QtWidgets import *

import nmap

import os

def launch():
    os.system("ssh ubuntu@rpi9.local ./ros2_ws/launch.sh")



def getIP():
    nm = nmap.PortScanner()
    nm.scan(hosts='192.168.1.*', arguments='-sn')
    return nm.all_hosts()



def on_button_clicked():
    label.setText("Running nmap")
    QApplication.processEvents()
    hosts = getIP()
    hosts_text = '\n'.join(hosts)
    label.setText(hosts_text)


app = QApplication([])
window = QWidget()
layout = QVBoxLayout()
button = QPushButton('GetIP')
launch_but = QPushButton('launch')
label = QLabel("...")
layout.addWidget(button)
layout.addWidget(label)
layout.addWidget(launch_but)
window.setLayout(layout)



button.clicked.connect(on_button_clicked)
launch_but.clicked.connect(launch)

window.show()
app.exec()