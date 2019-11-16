# Kernel cmdline argument for realtime systems
# See https://www.kernel.org/doc/Documentation/admin-guide/kernel-parameters.txt

APPEND += " xenomai.allowed_group=1234 xenomai.sysheap_size=256 xenomai.state=enabled xenomai.smi=detect xenomai.smi_mask=1 nosmap"
