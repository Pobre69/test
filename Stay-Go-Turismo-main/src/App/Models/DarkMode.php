<?php

namespace DarkMode\Models;

class DarkMode{
    public ?bool $isDark;

    public function setMode(bool $data) {
        $this->isDark = $data ?? false;
    }

    public function getMode(): bool {
        return $this->isDark ?? false;
    }
}