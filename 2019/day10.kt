// kotlinc day10.kt -include-runtime -d day10.jar && java -jar day10.jar && rm day10.jar

import java.io.File
import kotlin.math.atan2

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
        asteroids
            .filter { it != point }
            .map {
                val dx = it.first - point.first
                val dy = it.second - point.second
                atan2(dx.toDouble(), dy.toDouble())
            }
            .distinct()
            .count()
    }

    println(detects.max())
}
