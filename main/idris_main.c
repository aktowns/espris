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
};

void app_main()
{
    ESP_LOGI(TAG, "booting esp");

    VM* vm = init_vm(opts.max_stack_size, opts.init_heap_size, 1);

    init_threadkeys();
    init_threaddata(vm);
    init_gmpalloc();

    init_nullaries();
    init_signals();

    _idris__123_runMain_95_0_125_(vm, NULL);

#ifdef IDRIS_DEBUG
     idris_gcInfo(vm, 1);
#endif

    Stats stats = terminate(vm);

    print_stats(&stats);

    for (;;) {}
}
