#include "idris_opts.h"
#include "idris_stats.h"
#include "idris_rts.h"

#include <stdio.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_system.h"
#include "esp_spi_flash.h"
#include "esp_log.h"

void _idris__123_runMain_95_0_125_(VM* vm, VAL* oldbase);

static const char *TAG = "idris-entry";

// The default options should give satisfactory results under many circumstances.
RTSOpts opts = {
    .init_heap_size = 128,
    .max_stack_size = 128,
    .show_summary   = 0
};

void app_main()
{
    ESP_LOGI(TAG, "booting esp");

    VM* vm = init_vm(opts.max_stack_size, opts.init_heap_size, 1);
    _idris__123_runMain_95_0_125_(vm, NULL);

#ifdef IDRIS_DEBUG
    if (opts.show_summary) {
        idris_gcInfo(vm, 1);
    }
#endif
}
