// kotlinc day10.kt -include-runtime -d day10.jar && java -jar day10.jar && rm day10.jar

import java.io.File
import kotlin.math.atan2
import kotlin.math.hypot

fun main() {
    val asteroids = mutableListOf<Pair<Int, Int>>()
    var y = 0

    File("res/day10.txt").forEachLine {
        it.forEachIndexed { x, char ->
            if (char == '#') { asteroids += Pair(x, y) }
        }
        y += 1
    }

    val detects = asteroids.map { point ->
        asteroids.filter { it != point }
            .map {
                val dx = it.first - point.first
                val dy = it.second - point.second
                atan2(dx.toDouble(), dy.toDouble())
            }
            .distinct()
            .count()
    }

    println(detects.max())

    val max = asteroids.maxBy { point ->
        asteroids.filter { it != point }
            .map {
                val dx = it.first - point.first
                val dy = it.second - point.second
                atan2(dx.toDouble(), dy.toDouble())
            }
            .distinct()
            .count()
    }!!

    val grouped = asteroids.groupBy {
        val dx = it.first - max.first
        val dy = it.second - max.second
        atan2(dy.toDouble(), dx.toDouble())
    }

    var angle = -Math.PI / 2
    var first = true
    var result = asteroids.first()

    (1..200).forEach {
        val angles = grouped
            .filter { if (first) it.key >= angle else it.key > angle }
            .minBy { it.key }
            ?: grouped.minBy { it.key }!!

        angle = angles.key
        first = false

        result = angles.value.minBy {
            val dx = it.first - max.first
            val dy = it.second - max.second
            hypot(dx.toDouble(), dy.toDouble())
        }!!
    }

    println(result.first * 100 + result.second)
}
